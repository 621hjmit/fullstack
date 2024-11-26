const $itemHeader = $('.item-header');
var str = "<span class='dropdown-plus'></span>"
$('.item-header').append(str);

$itemHeader.click(function(){
    const $this = $(this);
    if(!$this.hasClass('on')){
        $('.item-header.on').next().slideUp();
        $('.item-header.on').removeClass('on');
        $this.addClass('on');
        $this.next().slideDown();
    }else{
        $('.item-header.on').next().slideUp();
        $('.item-header.on').removeClass('on');
    }
});