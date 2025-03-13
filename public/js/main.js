document.addEventListener('DOMContentLoaded', function() {
    // Mobilmeny
    const mobileMenuToggle = document.querySelector('.mobile-menu-toggle');
    const mainNav = document.querySelector('.main-nav');

    if (mobileMenuToggle && mainNav) {
        mobileMenuToggle.addEventListener('click', function() {
            mainNav.classList.toggle('active');
            this.classList.toggle('active');
        });
    }

    // Lukk mobilmenyen når man klikker utenfor
    document.addEventListener('click', function(event) {
        if (!event.target.closest('.mobile-menu-toggle') && !event.target.closest('.main-nav')) {
            if (mainNav && mainNav.classList.contains('active')) {
                mainNav.classList.remove('active');
                mobileMenuToggle.classList.remove('active');
            }
        }
    });

    // Søkefunksjonalitet
    const searchInput = document.querySelector('.search-input');
    if (searchInput) {
        searchInput.addEventListener('input', debounce(function(e) {
            const searchTerm = e.target.value.toLowerCase();
            // Her kan du implementere søkelogikken
            // For eksempel ved å bruke Lunr.js eller lignende
        }, 300));
    }
});

// Hjelpefunksjon for å begrense antall søk
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
} 