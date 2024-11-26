<%@page import="com.shop.hermesplus.user.vo.UserInfoVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!-- 로컬 CSS -->
<link rel='stylesheet' href='/static/css/terms.css' />
<link rel='stylesheet' href='/static/css/user/user.css' />

<!-- 로컬 js -->
<script src='/static/js/script.js' defer></script>
<script src='/static/js/user/mypage.js' defer></script>
<!-- 헤더 끝 기분좋아서 주석 쿠헤헤 -->

<main id="main" class="margin-top-60 margin-bottom-60 mobile-padding-rl-15 user">
    <div class="main-container">
      <div class="flex flex-center">
        <div class=" w-20p">
          <%@ include file="/WEB-INF/views/common/mypage-nav.jsp" %>
        </div>
        <div class="bright-back-color w-80p">
          <div class="title flex space-between">
            <h1 class="boxed-title">주소록</h1>
          </div>
          <div class="p-20px" id="">
            <h2 class="fs-33 fw-bold margin-bottom-20">새 배송지 주소 입력</h2>
            <div class="generic-input-box">
              <input type="text" id="aiPlaceName" name="aiPlaceName" class="generic-input required-input" required value="">
              <label class="generic-label" for="aiPlaceName">배송지명 <span aria-hidden="true"> *</span></label>
            </div>
            <div class="generic-input-box">
              <input type="text" id="aiRecipentName" name="aiRecipentName" class="generic-input required-input" required value="">
              <label class="generic-label" for="aiRecipentName">수령인 <span aria-hidden="true"> *</span></label>
            </div>
            <div class="row gap20 m-row">
              <div class="col-md-5 generic-input-box">
                <input type="text" id="aiZipcode" name="aiZipcode" class="generic-input required-input" required>
                <label class="generic-label" for="aiZipcode">우편번호 <span aria-hidden="true"> *</span></label>
                <div class="warning-required">
                  <span>필수항목</span>
                </div>
              </div>
              <div class="col-md-5 generic-input-box">
                <input type="button" id="search" name="search" class="btn btn-border-black" value="우편번호 검색" onclick="getAddress()">
              </div>
            </div>
            <div class="generic-input-box">
              <input type="text" id="aiAddress1" name="aiAddress1" class="generic-input required-input" required value="">
              <label class="generic-label" for="aiAddress1">주소 1 <span aria-hidden="true">*</span></label>
            </div>
            <div class="generic-input-box">
              <input type="text" id="aiAddress2" name="aiAddress2" class="generic-input required-input" required value="">
              <label class="generic-label" for="aiAddress2">주소 2 <span aria-hidden="true">*</span></label>
            </div>
            <div class="row m-row">
              <div class="col generic-input-box width90">
                <input type="tel" id="aiCountryCode" name="aiCountryCode" class="generic-input required-input" required value="+82" maxlength="5">
                <label class="generic-label" for="aiCountryCode">국가 코드 <span aria-hidden="true">*</span></label>
              </div>
              <div class="col generic-input-box">
                <input type="tel" id="aiPhone" name="aiPhone" class="generic-input required-input" required>
                <label class="generic-label" for="aiPhone">휴대전화 <span aria-hidden="true"> *</span></label>
              </div>
            </div>
            <div class="info hide" id="phoneInfo">
              <p class="text-xxsmall">휴대폰번호의 첫 자리 0을 제외하고 1부터 작성해 주십시오.</p>
            </div>
            <div class="row" id="aiDefaultWrapper">
              <input type="checkbox" id="aiDefault" name="aiDefault" data-format="checkDefault" value="1">
              <label class="" for="aiDefault" id="">기본 배송지로 설정합니다.</label>
            </div>
	          <input type="button" id="save" name="save" class="button-base button-primary height-normal mt-40 mb-25" value="저장" onclick="save()">
          </div>
        </div>
      </div>
    </div><!-- .main-container -->
</main>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
var user = '<c:out value="${user}"/>'
let userObject = null;
const aiNum = '${param.aiNum}';
let aiDefault = 0; 
window.onload = init;
function init(){
    if(!user){
      location.href='/views/user/login';
    }else{
      // user가 string으로 되어있어서 object화 한다. 
      userObject = Object.fromEntries(
        user.match(/(\w+)=([^,]+)/g).map(pair => pair.split('='))
      );
    }
  }
$('#aiPhone').blur(function(event){
  const $this = $(this);
  let str = $this.val();
  if(str.indexOf(0)=='0'){
    str = str.substring(1);
    $this.val(str);
  }
  $('#phoneInfo').addClass('hide');
});
$('#aiPhone').on('focus', function(event){
    $('#phoneInfo').removeClass('hide');
  });
$('#aiPhone').on( "keydown", function( event ) {
  const $this = $(this);
  let str = $this.val();
  if ( event.which == 96 && str.length < 1 ) {
    event.preventDefault();
  }
});
$('#aiCountryCode').on('input', function() {
  // 기본값이거나 첫 번째 글자가 +인지 확인
  if (!this.value.startsWith('+')) {
    this.value = '+' + this.value.replace(/[^0-9]/g, ''); // + 기호가 없으면 추가
  } else {
    // 숫자만 입력되도록 + 뒤의 문자 중 숫자가 아닌 것은 제거
    this.value = '+' + this.value.slice(1).replace(/[^0-9]/g, '');
  }
});
function checkDefault(obj, data){
  if(data=='1'){
    //obj.checked = true;
    //aiDefault = true;
    document.getElementById("aiDefaultWrapper").remove();
  }
}
function getAddress() {
  new daum.Postcode({
    oncomplete: function(data) {
      // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
  
      // 각 주소의 노출 규칙에 따라 주소를 조합한다.
      // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
      var addr = ''; // 주소 변수
      var extraAddr = ''; // 참고항목 변수
      let type = 'R';
  
      //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
      if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
        addr = data.roadAddress;
      } else { // 사용자가 지번 주소를 선택했을 경우(J)
        addr = data.jibunAddress;
      }
  
      // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
      if(data.userSelectedType === 'R'){
        // 법정동명이 있을 경우 추가한다. (법정리는 제외)
        // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
        if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
          extraAddr += data.bname;
        }
        console.log(data.buildingName);
        // 건물명이 있으면 넣는다.
        if(data.buildingName !== ''){
          extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
        }
        // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
        if(extraAddr !== ''){
          extraAddr = ' (' + extraAddr + ')';
          addr += extraAddr;
        }
        // 조합된 참고항목을 해당 필드에 넣는다.
      
      }
  
      // 우편번호와 주소 정보를 해당 필드에 넣는다.
      document.getElementById('aiZipcode').value = data.zonecode;
      document.getElementById("aiAddress1").value = addr;
      // 커서를 상세주소 필드로 이동한다.
      document.getElementById("aiAddress2").value = '';
      document.getElementById("aiAddress2").focus();
    }
  }).open();
}
function save(){
  console.log('userObject.uiNum : '+userObject.uiNum);
  let aiDefault2 = '0';
  if(document.getElementById("aiDefaultWrapper")){
    let checkDefault = document.getElementById("aiDefault").checked ;
    if(checkDefault){
      aiDefault2 = '1';
    }
  }else{
    aiDefault2 = '1';
  }
  
  const param = {
    aiNum           :    aiNum             ,
    aiPlaceName     :    document.getElementById('aiPlaceName').value             ,
    aiRecipentName  :    document.getElementById('aiRecipentName').value        ,
    aiCountryCode   :    document.getElementById('aiCountryCode').value      ,
    aiPhone         :    document.getElementById('aiPhone').value            ,
    aiZipcode       :    document.getElementById('aiZipcode').value          ,
    aiAddress1      :    document.getElementById('aiAddress1').value            ,
    aiAddress2      :    document.getElementById('aiAddress2').value            ,
    aiDefault       :    aiDefault2,
    uiNum           :    userObject.uiNum
  }
  const cof = {
    method    : 'POST',
    url       : '/address3',
    json      : true,
    callback  : function(res){
      if(res>0){
        alert("새 주소를 등록하였습니다.");
        location.href = "/views/user/address";
      }else{
        alert("새 주소를 등록에 실패하였습니다. 고객센터에 연락 부탁드립니다.");
      }
    },
    param     : JSON.stringify(param)
  }
  ajax(cof);
}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>