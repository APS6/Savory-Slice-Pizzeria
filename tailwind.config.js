/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './pages/**/*.{js,ts,jsx,tsx,mdx}',
    './components/**/*.{js,ts,jsx,tsx,mdx}',
    './app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    colors: {
      colbg: '#FFE6C6',
      col2: '#DB3A34',
      col3: '#FF7043',
      col4: '#333333',
    },
    fontFamily: {
      ff1: ['Arvo', 'serif'],
      ff2: ['Merriweather', 'serif'],
      ff3: ['Oswald', 'sans-serif'],
    },
    extend: {
      
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
  ],
}
