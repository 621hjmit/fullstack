
var swiper = new Swiper(".mySwiper", {
    spaceBetween: 0,
    autoplay: false,
    loop: true,
    navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev",
    },

  });
$('.swiper-button-next').click(function(){
    //console.log('clicked');
});