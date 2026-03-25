<template>
  <v-app>
    <v-app-bar
      :elevation="0"
      class="nav-bar"
      height="64"
    >
      <v-container class="d-flex align-center py-0" style="max-width: 1200px">
        <a href="#hero" class="nav-logo text-decoration-none d-flex align-center">
          <span class="logo-bracket">&lt;</span>
          <span class="logo-name">K</span>
          <span class="logo-bracket">/&gt;</span>
        </a>

        <v-spacer />

        <div class="d-none d-sm-flex align-center ga-1">
          <v-btn
            v-for="link in navLinks"
            :key="link.href"
            :href="link.href"
            variant="text"
            size="small"
            class="nav-link text-none"
          >
            {{ link.label }}
          </v-btn>
        </div>
      </v-container>
    </v-app-bar>

    <v-main>
      <slot />
    </v-main>
  </v-app>
</template>

<script setup lang="ts">
const navLinks = [
  { label: 'About', href: '#about' },
  { label: 'Skills', href: '#skills' },
]
</script>

<style scoped lang="scss">
.nav-bar {
  background: rgba(0, 0, 0, 0.85) !important;
  backdrop-filter: blur(20px);
  border-bottom: 1px solid rgba(0, 255, 65, 0.08);
}

.nav-logo {
  font-family: 'Fira Code', monospace;
  font-size: 1.25rem;
  font-weight: 600;
  gap: 2px;
}

.logo-bracket {
  color: rgba(0, 255, 65, 0.5);
}

.logo-name {
  color: #00ff41;
  text-shadow: 0 0 10px rgba(0, 255, 65, 0.6);
}

.nav-link {
  color: rgba(0, 255, 65, 0.5) !important;
  font-family: 'Fira Code', monospace;
  font-size: 0.85rem;
  font-weight: 500;
  letter-spacing: 0.03em;
  transition: color 0.3s ease;

  &:hover {
    color: #00ff41 !important;
    text-shadow: 0 0 8px rgba(0, 255, 65, 0.5);
  }
}
</style>
