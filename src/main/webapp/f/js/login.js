let pcFlag;
let $userEmail=$('#userEmail');
let regEmail=/^[a-zA-Z0-9]([-_.]?\w+)*@[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*\.[a-zA-Z]{2,3}$/g;
checkDevice();
mobileClass();
$userEmail.on('blur', function(){
    if(!regEmail.test($userEmail.val())){
        $userEmail.popWarning("name@domain.com과 같은 형식의 유효한 이메일을 입력해 주세요.");
    }
});

$.fn.popWarning = function(str){
    var $this = $(this);
    $this.addClass('generic-input-error');
    $this.siblings('.warning-required').addClass('show');
    $this.siblings('.warning-required').children('span').html(str);
}

$.fn.warningRequired = function(){
    var $this = $(this);
    value = $this.val();
    if(!value){
        $this.addClass('generic-input-error');
        $this.siblings('.warning-required').addClass('show');
    }else{
        $this.removeClass('generic-input-error');
        $this.siblings('.warning-required').removeClass('show');
    }

}
//.warning-required
$('.required-input').on( "focusout", function(){
    $(this).warningRequired();
});

//윈도우 리사이즈시 실행 영역 ---------------------

$( window ).on( "resize", function() {
    checkDevice();
    mobileClass();
});

//-------------------------------------------------
function mobileClass(){
    if(!pcFlag){ //모바일이면
        $('main').addClass('mobile');
    }else{
        $('main').removeClass('mobile');
    }
}
function checkDevice(){
    if($(window).width()>751){
        pcFlag= true;
    }else{
        pcFlag=false;
    }
}