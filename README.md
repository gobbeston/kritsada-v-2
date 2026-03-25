# Kritsada V2

Admin Dashboard built with Nuxt 4, Vue 3, Vuetify 4, and Pinia.

## Tech Stack

| Technology | Version |
|---|---|
| Nuxt | ^4.4.2 |
| Vue | ^3.5.30 |
| Vuetify | ^4.0.3 |
| Pinia | ^3.0.4 |
| Sass | ^1.98.0 |
| Node.js | 22 (see `.nvmrc`) |

## Prerequisites

- [Node.js](https://nodejs.org/) v22 or later
- [nvm](https://github.com/nvm-sh/nvm) (recommended)
- [Docker](https://www.docker.com/) (for containerised deployment)

## Setup

```bash
# Switch to the correct Node version
nvm use

# Install dependencies
npm install
```

## Development

```bash
# Start dev server at http://localhost:3000
npm run dev
```

## Production

```bash
# Build for production
npm run build

# Preview production build locally
npm run preview
```

## Docker

### Using Docker Compose

```bash
docker compose up --build
# Open http://localhost:3000
```

To pass a local `.env` file, uncomment the `env_file` section in `docker-compose.yml`.

### Using Docker directly

```bash
# Build the image
docker build -t kritsada-v-2 .

# Run the container
docker run -p 3000:3000 kritsada-v-2
```

## Project Structure

```
kritsada-v-2/
├── app/
│   ├── app.vue              # Root component
│   ├── assets/styles/       # SCSS styles
│   ├── components/          # Reusable Vue components
│   ├── composables/         # Vue 3 composables
│   ├── constants/           # Static config / labels
│   ├── layouts/             # Page layouts
│   ├── middleware/           # Route middleware
│   ├── pages/               # File-based routing
│   ├── plugins/             # Nuxt plugins
│   ├── services/            # HTTP / API services
│   └── stores/              # Pinia stores
├── server/
│   ├── api/                 # Nitro API routes
│   └── middleware/          # Server middleware
├── public/                  # Static files
├── nuxt.config.ts           # Nuxt configuration
└── .nvmrc                   # Node version lock
```

## Learn More

- [Nuxt Documentation](https://nuxt.com/docs/getting-started/introduction)
- [Vuetify Documentation](https://vuetifyjs.com/)
- [Pinia Documentation](https://pinia.vuejs.org/)
- [Deployment Guide](https://nuxt.com/docs/getting-started/deployment)
