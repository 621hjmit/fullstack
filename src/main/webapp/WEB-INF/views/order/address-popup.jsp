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
          <div class="title flex space-between">
            <h1 class="boxed-title">주소록</h1>
          </div>
          <div class="p-20px" id="">
            <p class="pb-20px">배송하실 주소를 선택해 주세요.</p>
            <div id="addressList">
            </div>
<!--             <div class="flex f-center">
              <button type="button" class="btn btn-200 button-primary m-auto" onclick="add()">주소 추가하기</button>
            </div>
 -->          </div>
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

<script>
var user = '<c:out value="${user}"/>'
let userObject = null;
window.onload = init;
function init(){
	if(!user){
	  location.href='/views/user/login';
	}else{
		userObject = Object.fromEntries(
      user.match(/(\w+)=([^,]+)/g).map(pair => pair.split('='))
    );
		getData();
	}
}
function getData(){
  const param = {
    uiNum       :   userObject.uiNum
  }
  const cof = {
    method    : 'post',
    url       : '/address',
    json      : true,
    callback  : function(res){
    	res = JSON.parse(res);
    	let htmlContent ='';
    	for (let i = 0; i < res.length; i++) {
	      const item = res[i];
	      if(item.aiDefault==1){
		      htmlContent += 
	        '<div class="border border-radius p-20px mb-20px flex m-row flex-space-between">'+
	          '<div class="">'+
		          '<p><b>* 기본 주소</b></p>'+
	            '<p><b>'+ item.aiPlaceName +'</b> '+ item.aiRecipentName +'</p>'+
	            '<p>'+ item.aiAddress1 +' '+ item.aiAddress2+' '+ item.aiZipcode+'</p>'+
	            '<p>'+ item.aiCountryCode +' '+ item.aiPhone+'</p>'+
		        '</div>'+
		        '<div class="w-50">'+
		          '<button typed="button" class="text-underline" onclick="modifyAddress('+item.aiNum+')">수정하기</button>'+
		          '<br/><button typed="button" class="text-underline" onclick="movetoCart('+item.aiNum+')">선택하기</button>'+
		        '</div>'+
		      '</div>';
	      }
      }
    	for (let i = 0; i < res.length; i++) {
        const item = res[i];
        if(item.aiDefault!=1){
          htmlContent += 
          '<div class="border border-radius p-20px mb-20px flex m-row flex-space-between">'+
            '<div class="">'+
              '<p><b>'+ item.aiPlaceName +'</b> '+ item.aiRecipentName +'</p>'+
              '<p>'+ item.aiAddress1 +' '+ item.aiAddress2+' '+ item.aiZipcode+'</p>'+
              '<p>'+ item.aiCountryCode +' '+ item.aiPhone+'</p>'+
            '</div>'+
            '<div class="w-50">'+
              '<button typed="button" class="text-underline" onclick="modifyAddress('+item.aiNum+')">수정하기</button>'+
              '<br/><button typed="button" class="text-underline" onclick="movetoCart('+item.aiNum+')">선택하기</button>'+
              '<br/><button typed="button" class="text-underline" onclick="deleteAddress('+item.aiNum+')">삭제하기</button>'+
            '</div>'+
          '</div>';
        }
      }
    	document.getElementById('addressList').innerHTML += htmlContent;
    },
    param   : JSON.stringify(param)
  }
  ajax(cof);
}
function modifyAddress(number){
	location.href = '/views/user/address-modify?aiNum='+number;
}
function movetoCart(aiNum){
	if (window.opener && !window.opener.closed) {
	    window.opener.getDeliveryInfo(aiNum);
	    window.close(); // 선택 후 창 닫기
	}
	window.close();	
}


function deleteAddress(number){
  const xhr = new XMLHttpRequest();
  xhr.open('DELETE','/address/'+number);
  xhr.onreadystatechange = function (){
    if(xhr.readyState === xhr.DONE){
      if(xhr.status === 200){
        console.log(xhr.responseText);
        if(xhr.responseText==='1'){
          alert('해당 배송지를 삭제하였습니다.');
          location.reload();
        }else{
          alert('해당 배송지를 삭제하지 못하였습니다.');
          location.reload();
        }
      }
    }
  }
  xhr.send();
  /*
  const conf = {
      url : '/address/${param.aiNum}',
      method : 'DELETE',
      param : number,
      json : true,
      callback : function(res){
        if(!res){
          alert('삭제실패');
        }else{
          alert("delet 성공");
        }
      }
  }
  ajax(conf);
  */
}
function add(){
	  location.href="/views/user/address-insert-popup";
}
</script>

</body>
</html>