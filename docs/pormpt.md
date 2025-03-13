<specs>
- **Website Type**: A Hugo-based website focused on providing text examples and writing tips for various occasions.
- **Design Inspiration**: The website should be visually similar to Teksttips.no, featuring a **clean, minimalistic**, and **user-friendly** layout.
- **Color Scheme**: A light color palette, primarily **white and soft gray** with blue or green accents for buttons and links.
- **Typography**: Use a **readable, elegant font** that windows and mac users have installed on their computer for optimal speed
  - **Header**: Logo on the left, menu in the center or right.
  - **Main Menu Items**: Home, Categories, Contact.
  - **Dropdown Support**: Categories menu should allow subcategories.
- **Homepage Layout**:
  - A large **hero section** with an introductory text about the website.
  - A grid-based or list-based **preview of the latest articles**, each showing:
    - Title
    - A short excerpt (meta description)
    - A featured image (if available)
  - Sidebar (optional): Can include recent posts, a search box, and a small **“About the site”** section.
- **Category Pages**:
  - Display a list of articles within the category, arranged in a grid or list.
  - Each article block should show:
    - Title
    - Short excerpt
    - Publication date
- **Single Article Page**:
  - Large, readable text with **clear paragraph spacing**.
  - A simple **breadcrumb navigation** at the top.
  - A sidebar (optional) with related posts.
  - A clean, unobtrusive **social media share section**.
- **Footer**:
  - Simple footer with **contact info**, links to **privacy policy**, and a small copyright notice.
- **Mobile Responsiveness**:
  - The design must be **fully responsive**.
  - On mobile, the menu should collapse into a **hamburger menu**.
- **Technical Requirements**:
  - Hugo version: Should work with the latest stable release.
  - **Theme Folder**: The custom theme should be placed inside `themes/custom-theme/`.
  - **Hugo Taxonomies**: Use Hugo’s built-in taxonomy system to organize content by **categories and tags**.
  - **Static Content Format**: Articles should be written as Markdown (`.md`) files inside `content/` folder.
  - **SEO Best Practices**:
    - Meta title and description should be dynamically generated.
    - Clean, SEO-friendly URLs (`/category/article-title/`).
    - Use schema markup for articles.
- **Search Functionality**:
  - Implement a **client-side search bar** (using Lunr.js or similar).
- **Performance Considerations**:
  - Ensure **fast loading times** by optimizing CSS and using **lazy loading** for images.
- **Contact Page**:
  - A simple contact form (use Formspree or a similar service for email submissions).
- **Hosting Compatibility**:
  - The website should be **deployable on Netlify, GitHub Pages, or any static hosting service**.
</specs>

<your-task>
- Build a **Hugo website** using the details from `<specs>`.
- Develop a **custom Hugo theme** that mimics Teksttips.no’s design and layout.
- Implement **homepage, category pages, article pages, and a contact page**.
- Configure **Hugo templates** using `layouts/` for:
  - `layouts/index.html` (Homepage)
  - `layouts/_default/list.html` (Category pages)
  - `layouts/_default/single.html` (Article pages)
- Ensure **SEO-friendly meta tags** and structured data.
- Optimize for **speed and mobile responsiveness**.
</your-task>

<rules>
- Ensure **all fonts, icons, and images** are either open-source or customizable.
- Use **only clean, well-commented code**.
- Follow **Hugo best practices** for site structure and performance.
- Ensure the theme is **fully customizable** (allow users to modify colors, fonts, and layout).
- Site has to be in norwegian
</rules>

<info>
categories: 1. bursdagshilsen, 2. bryllup, 3. dikt, 4. visomsord

</info>
