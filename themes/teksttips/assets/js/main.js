// Remove no-js class immediately
// Navigation functionality
document.addEventListener('DOMContentLoaded', function() {
    // Remove no-js class
    document.documentElement.classList.remove('no-js');
    
    // Dropdown menu
    const dropdownBtn = document.querySelector('.dropbtn');
    const dropdownContent = document.querySelector('.dropdown-content');

    if (dropdownBtn && dropdownContent) {
        dropdownBtn.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
            dropdownContent.classList.toggle('show');
        });

        document.addEventListener('click', function(e) {
            if (!e.target.matches('.dropbtn') && dropdownContent.classList.contains('show')) {
                dropdownContent.classList.remove('show');
            }
        });
    }

    // Mobile menu
    const mobileMenuBtn = document.querySelector('.mobile-menu-toggle');
    const mainNav = document.querySelector('.main-nav');

    if (mobileMenuBtn && mainNav) {
        mobileMenuBtn.addEventListener('click', function() {
            mainNav.classList.toggle('active');
            this.classList.toggle('active');
        });
    }
    
    // Lazy load images
    const lazyImages = document.querySelectorAll('img[data-src]');
    if ('IntersectionObserver' in window) {
        const imageObserver = new IntersectionObserver((entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const img = entry.target;
                    img.src = img.dataset.src;
                    img.onload = () => {
                        img.style.backgroundImage = 'none';
                    };
                    imageObserver.unobserve(img);
                }
            });
        });

        lazyImages.forEach(img => {
            imageObserver.observe(img);
        });
    } else {
        // Fallback for browsers without IntersectionObserver
        lazyImages.forEach(img => {
            img.src = img.dataset.src;
        });
    }
}); 