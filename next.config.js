/** @type {import('next').NextConfig} */
const nextConfig = {
  // output: 'export',
  trailingSlash: true,
  images: {
    unoptimized: true,
  },
  // // Uncomment these for GitHub Pages
  // ...(process.env.NODE_ENV === 'production' && {
  //   basePath: '/player-stats-dashboard',
  //   assetPrefix: '/player-stats-dashboard/',
  // }),
}

module.exports = nextConfig