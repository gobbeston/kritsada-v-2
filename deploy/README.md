# Deploy to AWS EC2

Deploy the Nuxt 4 portfolio site to an EC2 instance with Docker, Nginx, and SSL.

## Prerequisites

- AWS CLI configured (`aws configure`)
- SSH Key Pair `KritsadaMe` exists in `ap-southeast-1`
- Domain `kritsada.me` with DNS access

---

## Step 1: Create Security Group

```bash
aws ec2 create-security-group \
  --group-name kritsada-web \
  --description "Web server for kritsada.me" \
  --region ap-southeast-1

# Allow SSH
aws ec2 authorize-security-group-ingress \
  --group-name kritsada-web \
  --protocol tcp --port 22 --cidr 0.0.0.0/0 \
  --region ap-southeast-1

# Allow HTTP
aws ec2 authorize-security-group-ingress \
  --group-name kritsada-web \
  --protocol tcp --port 80 --cidr 0.0.0.0/0 \
  --region ap-southeast-1

# Allow HTTPS
aws ec2 authorize-security-group-ingress \
  --group-name kritsada-web \
  --protocol tcp --port 443 --cidr 0.0.0.0/0 \
  --region ap-southeast-1
```

## Step 2: Find Ubuntu 24.04 AMI

```bash
aws ec2 describe-images \
  --owners 099720109477 \
  --filters "Name=name,Values=ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*" \
  --query 'Images | sort_by(@, &CreationDate) | [-1].ImageId' \
  --output text \
  --region ap-southeast-1
```

Copy the AMI ID from the output (e.g. `ami-xxxxxxxxxxxxxxxxx`).

## Step 3: Launch EC2 Instance

```bash
aws ec2 run-instances \
  --image-id <AMI_ID_FROM_STEP_2> \
  --instance-type t2.micro \
  --key-name KritsadaMe \
  --security-groups kritsada-web \
  --block-device-mappings '[{"DeviceName":"/dev/sda1","Ebs":{"VolumeSize":20,"VolumeType":"gp3"}}]' \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=kritsada-web}]' \
  --region ap-southeast-1
```

Note the `InstanceId` from the output.

## Step 4: Allocate and Associate Elastic IP

```bash
# Allocate
aws ec2 allocate-address --domain vpc --region ap-southeast-1

# Note the AllocationId, then associate
aws ec2 associate-address \
  --instance-id <INSTANCE_ID> \
  --allocation-id <ALLOCATION_ID> \
  --region ap-southeast-1
```

Note the Elastic IP (e.g. `13.x.x.x`).

## Step 5: Point DNS

Go to your DNS provider for `kritsada.me` and add:

| Type | Name | Value |
|------|------|-------|
| A | `@` (root) | `<ELASTIC_IP>` |
| A | `www` | `<ELASTIC_IP>` |

Wait for DNS propagation (can take a few minutes up to 48h).

## Step 6: SSH and Setup Server

```bash
ssh -i ~/.ssh/KritsadaMe.pem ubuntu@<ELASTIC_IP>
```

On the EC2 instance:

```bash
# Clone the repo
git clone git@github.com:gobbeston/kritsada-v-2.git
cd kritsada-v-2

# Make scripts executable
chmod +x deploy/setup.sh deploy/deploy.sh

# Run setup (installs Docker, Nginx, Certbot)
./deploy/setup.sh

# IMPORTANT: Log out and back in for Docker group to take effect
exit
```

SSH back in:

```bash
ssh -i ~/.ssh/KritsadaMe.pem ubuntu@<ELASTIC_IP>
cd kritsada-v-2
```

## Step 7: Deploy

```bash
./deploy/deploy.sh
```

Verify at `http://kritsada.me` (HTTP).

## Step 8: Enable SSL

```bash
sudo certbot --nginx -d kritsada.me -d www.kritsada.me
```

Follow the prompts (enter email, agree to terms). Certbot will:
- Obtain the SSL certificate
- Auto-configure Nginx for HTTPS
- Set up auto-renewal

Verify at `https://kritsada.me`.

---

## Updating the Site

After pushing changes to GitHub:

```bash
ssh -i ~/.ssh/KritsadaMe.pem ubuntu@<ELASTIC_IP>
cd kritsada-v-2
./deploy/deploy.sh
```

## Useful Commands

```bash
# View container logs
docker compose logs -f

# Restart container
docker compose restart

# Check Nginx status
sudo systemctl status nginx

# Renew SSL manually (auto-renewal is set up by certbot)
sudo certbot renew --dry-run
```
