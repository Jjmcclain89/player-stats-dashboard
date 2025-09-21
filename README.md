# Player Stats Dashboard

A Next.js application for displaying player statistics and event history.

## Getting Started

1. Navigate to the project directory:
   ```bash
   cd player-stats-dashboard
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Replace the sample data in `public/data/data.json` with your actual player data.

4. Run the development server:
   ```bash
   npm run dev
   ```

5. Open [http://localhost:3000](http://localhost:3000) in your browser.

## Features

- 🔍 Autocomplete search for players
- 📊 Comprehensive statistics display
- 📅 Event history table
- 📱 Responsive design
- ⚡ Fast loading with error handling

## Project Structure

```
player-stats-dashboard/
├── src/
│   ├── app/
│   │   ├── globals.css
│   │   ├── layout.tsx
│   │   └── page.tsx
│   └── components/
│       └── PlayerStatsApp.tsx
├── public/
│   └── data/
│       └── data.json
├── package.json
├── tailwind.config.js
└── tsconfig.json
```

## Customization

You can modify the component in `src/components/PlayerStatsApp.tsx` to add more features or change the styling.
