<template>
  <div>
    <!-- Matrix Rain Canvas (full page background) -->
    <canvas ref="matrixCanvas" class="matrix-rain" />

    <!-- ==================== HERO ==================== -->
    <section id="hero" class="hero-section">
      <v-container style="max-width: 1200px; position: relative; z-index: 1">
        <v-row align="center" justify="center" class="hero-content">
          <v-col cols="12" class="text-center">
            <p class="hero-greeting">Hello, I'm</p>
            <h1 class="hero-name glow-text">Kritsada</h1>
            <div class="typewriter-wrapper">
              <span class="typewriter-text">Full Stack Developer</span>
              <span class="typewriter-cursor" />
            </div>
            <p class="hero-description">
              No Code No Life
            </p>
            <div class="hero-actions">
              <v-btn
                color="primary"
                size="large"
                class="text-none hero-btn"
                href="#skills"
                rounded="lg"
              >
                <v-icon start>mdi-code-tags</v-icon>
                View Skills
              </v-btn>
              <v-btn
                variant="outlined"
                size="large"
                class="text-none hero-btn-outline"
                href="#about"
                rounded="lg"
              >
                <v-icon start>mdi-account</v-icon>
                About Me
              </v-btn>
            </div>
          </v-col>
        </v-row>
      </v-container>

      <div class="hero-scroll-indicator">
        <v-icon class="scroll-arrow">mdi-chevron-double-down</v-icon>
      </div>
    </section>

    <!-- ==================== ABOUT ==================== -->
    <section id="about" class="section">
      <v-container style="max-width: 1200px">
        <div class="text-center fade-in">
          <p class="section-label">// ABOUT ME</p>
          <h2 class="section-title glow-text">Who I Am</h2>
          <p class="section-subtitle">
            Passionate developer who loves turning ideas into reality
          </p>
        </div>

        <v-row class="mt-8" justify="center">
          <v-col
            v-for="stat in stats"
            :key="stat.label"
            cols="6"
            sm="3"
          >
            <v-card class="glass-card text-center pa-6 fade-in" rounded="xl">
              <v-icon :color="stat.color" size="36" class="mb-3">{{ stat.icon }}</v-icon>
              <div class="stat-value" :style="{ color: stat.color }">{{ stat.value }}</div>
              <div class="stat-label">{{ stat.label }}</div>
            </v-card>
          </v-col>
        </v-row>
      </v-container>
    </section>

    <!-- ==================== SKILLS ==================== -->
    <section id="skills" class="section">
      <v-container style="max-width: 1200px">
        <div class="text-center fade-in">
          <p class="section-label">// TECH STACK</p>
          <h2 class="section-title glow-text">Skills & Tools</h2>
          <p class="section-subtitle">
            Technologies I work with every day
          </p>
        </div>

        <v-row justify="center" class="mt-4">
          <v-col
            v-for="category in skillCategories"
            :key="category.title"
            cols="12"
            md="4"
          >
            <v-card class="glass-card pa-6 fade-in skill-category-card" rounded="xl">
              <div class="d-flex align-center mb-4">
                <v-icon :color="category.color" size="28" class="mr-3">{{ category.icon }}</v-icon>
                <h3 class="skill-category-title" :style="{ color: category.color }">
                  {{ category.title }}
                </h3>
              </div>
              <div class="d-flex flex-wrap ga-2">
                <v-chip
                  v-for="skill in category.skills"
                  :key="skill"
                  variant="tonal"
                  size="small"
                  class="skill-chip"
                >
                  {{ skill }}
                </v-chip>
              </div>
            </v-card>
          </v-col>
        </v-row>
      </v-container>
    </section>

    <!-- ==================== FOOTER ==================== -->
    <footer class="site-footer">
      <v-container style="max-width: 1200px">
        <v-row align="center">
          <v-col cols="12" class="text-center">
            <div class="footer-logo mb-2">
              <span class="logo-bracket">&lt;</span>
              <span class="logo-name">Kritsada</span>
              <span class="logo-bracket">/&gt;</span>
            </div>
            <p class="footer-text">
              &copy; {{ new Date().getFullYear() }} Kritsada. Built with Nuxt & Vuetify.
            </p>
          </v-col>
        </v-row>
      </v-container>
    </footer>
  </div>
</template>

<script setup lang="ts">
const matrixCanvas = ref<HTMLCanvasElement | null>(null)

useHead({
  title: 'Kritsada',
})

const stats = [
  { value: '10+', label: 'Years Experience', icon: 'mdi-calendar-check', color: '#00ff41' },
  { value: '20+', label: 'Projects', icon: 'mdi-folder-multiple', color: '#00cc33' },
  { value: '20+', label: 'Technologies', icon: 'mdi-code-braces', color: '#008f11' },
  { value: '100%', label: 'Passion', icon: 'mdi-heart', color: '#00ff41' },
]

const skillCategories = [
  {
    title: 'Frontend',
    icon: 'mdi-palette',
    color: '#00ff41',
    skills: ['Vue.js', 'Nuxt', 'React', 'TypeScript', 'Vuetify', 'Tailwind CSS', 'HTML/CSS', 'JavaScript'],
  },
  {
    title: 'Backend',
    icon: 'mdi-server',
    color: '#00cc33',
    skills: ['Go', 'Node.js', 'Express', 'NestJS', 'Python', 'PostgreSQL', 'MongoDB', 'Redis', 'REST API'],
  },
  {
    title: 'DevOps & Tools',
    icon: 'mdi-cloud-cog',
    color: '#008f11',
    skills: ['Docker', 'Git', 'CI/CD', 'Linux', 'AWS', 'Nginx', 'GitHub Actions', 'VS Code'],
  },
]

onMounted(() => {
  // Fade-in observer
  const observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add('visible')
        }
      })
    },
    { threshold: 0.1 },
  )
  document.querySelectorAll('.fade-in').forEach((el) => {
    observer.observe(el)
  })

  // Matrix digital rain
  const canvas = matrixCanvas.value
  if (!canvas) return

  const ctx = canvas.getContext('2d')
  if (!ctx) return

  const resize = () => {
    canvas.width = window.innerWidth
    canvas.height = document.documentElement.scrollHeight
  }
  resize()
  window.addEventListener('resize', resize)

  const chars = 'アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲン0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ<>/{}[]()=+-*&@#$%'
  const fontSize = 14
  const columns = Math.floor(canvas.width / fontSize)
  const drops: number[] = Array.from({ length: columns }, () => Math.random() * -100)

  const draw = () => {
    ctx.fillStyle = 'rgba(0, 0, 0, 0.05)'
    ctx.fillRect(0, 0, canvas.width, canvas.height)

    for (let i = 0; i < drops.length; i++) {
      const char = chars[Math.floor(Math.random() * chars.length)]
      const x = i * fontSize
      const y = drops[i] * fontSize

      // Brighter leading character
      if (Math.random() > 0.98) {
        ctx.fillStyle = '#ffffff'
        ctx.shadowColor = '#00ff41'
        ctx.shadowBlur = 15
      } else {
        const brightness = Math.random()
        if (brightness > 0.9) {
          ctx.fillStyle = 'rgba(0, 255, 65, 0.9)'
        } else if (brightness > 0.6) {
          ctx.fillStyle = 'rgba(0, 255, 65, 0.5)'
        } else {
          ctx.fillStyle = 'rgba(0, 143, 17, 0.4)'
        }
        ctx.shadowBlur = 0
      }

      ctx.font = `${fontSize}px 'Fira Code', monospace`
      ctx.fillText(char, x, y)

      if (y > canvas.height && Math.random() > 0.975) {
        drops[i] = 0
      }
      drops[i]++
    }

    requestAnimationFrame(draw)
  }

  draw()
})
</script>

<style scoped lang="scss">
.matrix-rain {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: 0;
  pointer-events: none;
  opacity: 0.4;
}

// ========== HERO ==========
.hero-section {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  position: relative;
  overflow: hidden;
  background: radial-gradient(ellipse at 50% 50%, rgba(0, 255, 65, 0.02) 0%, transparent 70%);
}

.hero-content {
  min-height: calc(100vh - 64px);
}

.hero-greeting {
  font-family: 'Fira Code', monospace;
  font-size: 1.1rem;
  color: rgba(0, 255, 65, 0.5);
  font-weight: 400;
  letter-spacing: 0.15em;
  text-transform: uppercase;
  margin-bottom: 0.5rem;
  animation: slide-up 0.8s ease-out both;
}

.hero-name {
  font-family: 'Fira Code', monospace;
  font-size: clamp(3rem, 10vw, 6rem);
  font-weight: 800;
  letter-spacing: -0.03em;
  line-height: 1.1;
  color: #00ff41;
  margin-bottom: 1rem;
  animation: slide-up 0.8s ease-out 0.1s both;
}

.typewriter-wrapper {
  display: inline-flex;
  align-items: center;
  margin-bottom: 1.5rem;
  animation: slide-up 0.8s ease-out 0.2s both;
}

.typewriter-text {
  font-family: 'Fira Code', monospace;
  font-size: clamp(1rem, 3vw, 1.3rem);
  color: rgba(0, 255, 65, 0.7);
  font-weight: 400;
}

.typewriter-cursor {
  display: inline-block;
  width: 2px;
  height: 1.4em;
  background: #00ff41;
  margin-left: 4px;
  animation: typewriter-cursor 1s step-end infinite;
  box-shadow: 0 0 8px rgba(0, 255, 65, 0.8);
}

.hero-description {
  font-family: 'Fira Code', monospace;
  font-size: 1.05rem;
  color: rgba(0, 255, 65, 0.4);
  max-width: 500px;
  margin: 0 auto 2.5rem;
  line-height: 1.7;
  animation: slide-up 0.8s ease-out 0.3s both;
}

.hero-actions {
  display: flex;
  gap: 16px;
  justify-content: center;
  flex-wrap: wrap;
  animation: slide-up 0.8s ease-out 0.4s both;
}

.hero-btn {
  font-family: 'Fira Code', monospace !important;
  font-weight: 600 !important;
  letter-spacing: 0.02em;
  background: rgba(0, 255, 65, 0.15) !important;
  color: #00ff41 !important;
  box-shadow: 0 0 20px rgba(0, 255, 65, 0.2);
  border: 1px solid rgba(0, 255, 65, 0.3);
  transition: all 0.3s ease;

  &:hover {
    box-shadow: 0 0 30px rgba(0, 255, 65, 0.4);
    background: rgba(0, 255, 65, 0.25) !important;
  }
}

.hero-btn-outline {
  font-family: 'Fira Code', monospace !important;
  font-weight: 600 !important;
  letter-spacing: 0.02em;
  border-color: rgba(0, 255, 65, 0.3) !important;
  color: #00ff41 !important;

  &:hover {
    background: rgba(0, 255, 65, 0.08) !important;
    border-color: rgba(0, 255, 65, 0.6) !important;
    box-shadow: 0 0 20px rgba(0, 255, 65, 0.2);
  }
}

.hero-scroll-indicator {
  position: absolute;
  bottom: 32px;
  left: 50%;
  transform: translateX(-50%);
  animation: float 3s ease-in-out infinite;
}

.scroll-arrow {
  color: rgba(0, 255, 65, 0.3) !important;
  font-size: 2rem !important;
}

// ========== SECTIONS ==========
.section-label {
  font-family: 'Fira Code', monospace;
  font-size: 0.8rem;
  font-weight: 500;
  letter-spacing: 0.15em;
  color: rgba(0, 255, 65, 0.6);
  margin-bottom: 0.5rem;
}

// ========== ABOUT ==========
.stat-value {
  font-family: 'Fira Code', monospace;
  font-size: 1.8rem;
  font-weight: 800;
  line-height: 1.2;
  margin-bottom: 4px;
  text-shadow: 0 0 10px rgba(0, 255, 65, 0.4);
}

.stat-label {
  font-family: 'Fira Code', monospace;
  font-size: 0.75rem;
  color: rgba(0, 255, 65, 0.4);
  font-weight: 500;
}

// ========== SKILLS ==========
.skill-category-card {
  height: 100%;
}

.skill-category-title {
  font-family: 'Fira Code', monospace;
  font-size: 1.15rem;
  font-weight: 700;
  letter-spacing: 0.01em;
  text-shadow: 0 0 8px rgba(0, 255, 65, 0.3);
}

.skill-chip {
  font-family: 'Fira Code', monospace !important;
  font-size: 0.75rem !important;
  font-weight: 500;
  background: rgba(0, 255, 65, 0.05) !important;
  color: rgba(0, 255, 65, 0.8) !important;
  border: 1px solid rgba(0, 255, 65, 0.12);
  transition: all 0.3s ease;

  &:hover {
    background: rgba(0, 255, 65, 0.12) !important;
    border-color: rgba(0, 255, 65, 0.4);
    box-shadow: 0 0 10px rgba(0, 255, 65, 0.15);
  }
}

// ========== FOOTER ==========
.site-footer {
  padding: 40px 0;
  border-top: 1px solid rgba(0, 255, 65, 0.08);
  position: relative;
  z-index: 1;
}

.footer-logo {
  font-family: 'Fira Code', monospace;
  font-size: 1.1rem;
  font-weight: 600;

  .logo-bracket {
    color: rgba(0, 255, 65, 0.5);
  }

  .logo-name {
    color: #00ff41;
    text-shadow: 0 0 10px rgba(0, 255, 65, 0.4);
  }
}

.footer-text {
  font-family: 'Fira Code', monospace;
  font-size: 0.8rem;
  color: rgba(0, 255, 65, 0.25);
}
</style>
