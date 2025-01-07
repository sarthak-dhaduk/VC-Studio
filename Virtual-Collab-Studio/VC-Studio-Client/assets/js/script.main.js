// Select the element you want to apply the effect to
const scrollableElement = document.querySelector('body'); // Adjust selector as needed

let isScrolling;

// Add event listener for scrolling
scrollableElement.addEventListener('scroll', () => {
    // Add the 'scroll-visible' class when scrolling
    scrollableElement.classList.add('scroll-visible');

    // Clear the previous timeout
    clearTimeout(isScrolling);

    // Set a timeout to remove the 'scroll-visible' class after scrolling stops
    isScrolling = setTimeout(() => {
        scrollableElement.classList.remove('scroll-visible');
    }, 500); // Adjust the delay (in ms) to control how long the scrollbar remains visible after scrolling stops
});
