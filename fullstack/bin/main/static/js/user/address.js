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
    location.href="/views/user/address-insert";
}
