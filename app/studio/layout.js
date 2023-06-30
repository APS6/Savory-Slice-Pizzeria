export const metadata = {
  title: 'Dashboard | Savory Slice',
  description: 'Admin dashboard to add products in Savory Slice Website',
}
 
export default function RootLayout({ children }) {
 return (
    <html lang="en">
      <body>{children}</body>
    </html>
  )
}
