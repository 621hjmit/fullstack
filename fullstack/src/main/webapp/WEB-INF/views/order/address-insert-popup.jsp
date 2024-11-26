<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="ko">

<head>
	<title>SKY 에르메스 공식 온라인 매장 | Hermès - 에르메스대한민국</title>
	<meta charset='utf-8'>

	<meta name='viewport' content='width=device-width, initial-scale=1.0'>
	<meta name='Title' content='Hermes paris'>
	<meta name='Subject' content='hermes website'>
	<meta name='Keywords' content='hermes'>
	<meta name='Author' content='sky'>
	<meta name='Publisher' content='hermes'>
	<meta name='Description' content=''>
	<meta name='Author-Date' content=''>
	<meta name='Copyright' content=''>

	<!-- 접근성 텍스트(skip) 숨김 -->
	<style>
		#skip {
			overflow: hidden;
			position: absolute;
			width: 0;
			height: 0;
			line-height: 0;
			text-indent: -9999px;
		}
	</style>

	<!-- 폰트어썸 -->
	<!-- <link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.5.0/css/all.css'>
	<link href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/fontawesome.min.css' rel='stylesheet'> -->
	<script src="https://kit.fontawesome.com/72a43b892a.js" crossorigin="anonymous"></script>
	
	<!-- 구글폰트 아이콘 -->
	<link rel='stylesheet'
	   href='https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0'>
	
	<!-- 제이쿼리 3.7 CDN -->
	<script src='https://code.jquery.com/jquery-3.7.1.min.js' crossorigin='anonymous'></script>
	<script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script> <!-- 메뉴 스윽 나올때 필요함. -->
	
	<!-- reset -->
	<link rel='stylesheet' href='/static/css/reset.css' />
	
	<!-- 로컬 CSS -->
	<link rel='stylesheet' href='/static/css/style.css' />
	<script>
		const imgPath = '/uploads/'
	</script>
	<!-- 로컬 js -->
	<script src='/static/js/common.js' defer></script>
	<script src='/static/js/script.js' defer></script>
	<script src='/static/js/main.js' defer></script>
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>

<body>
<!-- 시각장애인 웹 접근성을 위한 skip _ 지우지않아도 됩니다. -->
<header id="header">
	<!-- 로고 -->
	<div id="mainRowNavi" style="height:70px">
		<div id="leftMenu"></div>
		<a id="logo2" class="show-in-mobile" href="/">
			<span class="hiddentext">Hermes paris</span>
		</a>
		<div id="rightMenu"></div>
	</div>
	<div id="searchBackground" class="searchBackground"></div>
	<div id="mainRowNaviBack" class="show-in-mobile"></div>
</header>

<main id="main" class="margin-top-60 margin-bottom-60 mobile-padding-rl-15 user">
    <div class="main-container">
        <div class="bright-back-color w-80p">
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
    </div><!-- .main-container -->
</main>
<footer>
	<div class="footer-thirdsection m-text-center">
		<div class="copyright-block ng-star-inserted">
			<div class="copyright-block">
				<div id="logo3">
					<span class="hiddentext">Hermes paris</span>
				</div>
				<span class="sr-only">Copyright</span>
				<p>© Hermès 2024. 무단 전재와 무단 복제를 금함.</p>
			</div>
		</div>
	</div>
</footer>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
var user = '<c:out value="${user}"/>'
let userObject = null;
const aiNum = '${param.aiNum}';
let aiDefault = 0; 
window.onload = init;
function init(){
	// user가 string으로 되어있어서 object화 한다. 
	userObject = Object.fromEntries(
	user.match(/(\w+)=([^,]+)/g).map(pair => pair.split('='))
	);
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
  
  const params = {
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
	
	axios.post('/address3',params)
	.then(res =>{
		if(res.data>0){
			alert("새 주소를 등록하였습니다.");
			location.href="/views/order/address-popup";
		}else{
			alert("새 주소 등록에 실패하였습니다. 고객센터에 문의 부탁드립니다.");
		}
	});
}
</script>

</body>
</html>