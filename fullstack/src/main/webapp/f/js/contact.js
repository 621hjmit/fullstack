let $userFirstName=$('#userFirstName');
let $userLastName=$('#userLastName');
let $userEmail=$('#userEmail');
let $userPhone=$('#userPhone');

let regName=/^[a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣]{2,20}$/
let regEmail=/^[a-zA-Z0-9]([-_.]?\w+)*@[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*\.[a-zA-Z]{2,3}$/g;
let regPhone=/^[0-9]{8,}$/;


$userFirstName.on('blur', function(){
    if(!regName.test($userFirstName.val())){
        $userFirstName.popWarning("이름을 입력해 주세요.");
    }
});
$userLastName.on('blur', function(){
    if(!regName.test($userLastName.val())){
        $userLastName.popWarning("성을 입력해 주세요.");
    }
});
$userEmail.on('blur', function(){
    if(!regEmail.test($userEmail.val())){
        $userEmail.popWarning("name@domain.com과 같은 형식의 유효한 이메일을 입력해 주세요.");
    }
});
$userPhone.on('blur', function(){
    if(!regPhone.test($userPhone.val())){
        $userPhone.popWarning('최소 8글자 이상');
    }
});

// $userPhone최소 8글자 이상.

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
$('.required-select').on( "focusout", function(){
    $(this).warningRequired();
});
$('.required-textarea').on( "focusout", function(){
    $(this).warningRequired();
});

$('#userCountryCodes').on('keydown',function(e){
    var value = $(this).val();
    if(value =='+'&&e.keyCode == 8){
        e.preventDefault(); //국가코드 못지우게
    }
});

$('#csSubject').change(function () {
    var $this = $(this);
    if ($this.val() != '0') {
        $('.generic-select + label').addClass('selected');
    }
});

$('#userMessage').on('focus',function(e){
    console.log($(this).next().length);
    $('.generic-textarea + label').addClass('selected');
});

$('#userMessage').on('focusout',function(e){
    if ($(this).val()=='') {
        $('.generic-textarea + label').removeClass('selected');
    }
});
