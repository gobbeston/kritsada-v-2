// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2025-07-15',

  devtools: { enabled: true },

  ssr: true,

  modules: [
    'vuetify-nuxt-module',
    '@pinia/nuxt',
  ],

  css: ['~/assets/styles/main.scss'],

  app: {
    head: {
      titleTemplate: '%s',
      title: 'Kritsada',
      meta: [
        { charset: 'utf-8' },
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },
        { name: 'description', content: 'Kritsada — Full Stack Developer Portfolio' },
      ],
      link: [
        { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' },
        {
          rel: 'stylesheet',
          href: 'https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Fira+Code:wght@400;500&display=swap',
        },
      ],
    },
  },

  vuetify: {
    vuetifyOptions: {
      theme: {
        defaultTheme: 'dark',
        themes: {
          dark: {
            dark: true,
            colors: {
              background: '#000000',
              surface: '#0a0a0a',
              'surface-variant': '#0d1a0d',
              primary: '#00ff41',
              secondary: '#008f11',
              accent: '#00ff41',
              info: '#003b00',
              warning: '#00ff41',
              error: '#ff1744',
              success: '#00ff41',
            },
          },
        },
      },
      defaults: {
        VBtn: { variant: 'flat' },
      },
    },
  },
})
