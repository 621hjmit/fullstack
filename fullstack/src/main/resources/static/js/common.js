/**
 * 
 */

function getParam(){
   const formObjs = document.querySelectorAll('input');
   const param = new FormData();
   for(const formObj of formObjs){
      if(formObj.type==='file'){
         const file = formObj.files[0];
         if(file){
            param.append(formObj.id,file);
         }
      }else{
         param.append(formObj.id, formObj.value);
      }
   }
   return param;
}

function goPage(url){
   location.href = url;
}

function setData(obj){
   for(const key in obj){
      if(obj[key]){
         const el = document.querySelector('#' + key);
         if(el){
            if(el.tagName === 'IMG'){
               el.src = obj[key];
            }else{
               el.value = obj[key];
            }
         }
      }
   }
}

function previewImg(obj, targetId){
   const file = obj.files[0];
   const reader = new FileReader();
   reader.onload = function(){
      document.querySelector('#' + targetId).src=reader.result;
   }
   reader.readAsDataURL(file);
}

function ajax(conf){
  conf.method = conf.method?conf.method:'GET';
  const xhr = new XMLHttpRequest();
  let param = '';
  if(conf.param){
    if(conf.method !== 'GET'){ 
      param = conf.param;
    }else{
      conf.url = conf.url + '?' + conf.param;
    }
  }
  xhr.open(conf.method,conf.url);
  xhr.onreadystatechange = function(){
    if(xhr.readyState===xhr.DONE){
      if(xhr.status ===200){
        conf.callback(xhr.responseText);
      }
    }
  }
  if(conf.json){
    xhr.setRequestHeader('Content-Type','application/json');
  }
  xhr.send(param);
}
