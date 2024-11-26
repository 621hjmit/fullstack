<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
   <!-- 로컬 CSS -->
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
   <link rel='stylesheet' href='/static/css/style.css' />
   <link rel='stylesheet' href='/static/css/list.css' />
   <link rel='stylesheet' href='/static/css/swifer.css' />
   
   <!-- 로컬 js -->

   <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js" defer></script>
   <script src='/static/js/script.js' defer></script>
   <script src='/static/js/list.js' defer></script>      
   <script src='/static/js/swifer.js' defer></script>      
   
   <!-- 헤더 끝 기분좋아서 주석 쿠헤헤 -->
   <main id="main" class="margin-top-35">
      <ul class="breadcrumb main-padding">
         <li class="breadcrumb-item">여성</li>
         <li class="breadcrumb-item hidden" aria-hidden="true">여성복</li>
         <li class="breadcrumb-item active">봄-여름 2024 컬렉션 룩<span class="total-count">(203)</span></p></li>

      </ul>
      <div class="products-filter-container">
         <div class="products-filter">
            <form class="js-product-filter-form" method="get" id="product-filter">
               <button class="filterNavButton">필터
                  <span class="dropdown-btn-toggler"></span>
               </button>

               <div class="flex-left" id="filterBox">
                  <div class="show-in-mobile">
                     <div class="navHeader">
                        <div class="navbtns" id="filterClose">
                           <i class="nav-close">필터 닫기버튼</i>
                           <h9>필터</h9>
                        </div>
                     </div>
                  </div>
                  <fieldset class="switch-container">
                     <legend class="products-filter-group-legend">필터 기준 온라인스토어 구매가능</legend>
                     <input role="switch" type="checkbox" class="switch-input-default" id="online-switch" value="online">
                     <span class="switch-input"></span>
                     <label for="online-switch" id="online-text">온라인스토어 구매 가능</label>
                  </fieldset>
   
                  <fieldset class="dropdown-container dropdown-colorWithNames" style="">
                     <legend class="products-filter-group-legend">필터 기준 컬러</legend>
                     <button class="dropdown-btn js-dropdownbtn" aria-expanded="false"
                        aria-controls="dropdown-colorWithNames">
                        컬러
                        <span class="dropdown-btn-toggler"></span>
                     </button>
                     <div class="dropdown js-dropdown dropdown-checkbox" id="dropdown-colorWithNames" aria-hidden="true">
                        <ul class="dropdown-list">
                           <li class="inputwrapper">
                              <input class="custom-input" type="checkbox" data-name="colorWithNames"
                                 name="dropdown-colorWithNames" id="dropdown-colorWithNames-화이트ffffff" value="화이트_ffffff">
                              <label class="label" for="dropdown-colorWithNames-화이트ffffff">
                                 <span class="item-color" style="background:#ffffff;"></span>
                                 <span class="text">화이트</span>
                                 <span class="item-count">33</span>
                              </label>
                           </li>
                           <li class="inputwrapper">
                              <input class="custom-input" type="checkbox" data-name="colorWithNames"
                                 name="dropdown-colorWithNames" id="dropdown-colorWithNames-블루5b97c7" value="블루_5b97c7">
                              <label class="label" for="dropdown-colorWithNames-블루5b97c7">
                                 <span class="item-color" style="background:#5b97c7;"></span>
                                 <span class="text">블루</span>
                                 <span class="item-count">25</span>
                              </label>
                           </li>
                           <li class="inputwrapper">
                              <input class="custom-input" type="checkbox" data-name="colorWithNames"
                                 name="dropdown-colorWithNames" id="dropdown-colorWithNames-레드d92232" value="레드d92232">
                              <label class="label" for="dropdown-colorWithNames-레드d92232">
                                 <span class="item-color" style="background:#d92232;"></span>
                                 <span class="text">레드</span>
                                 <span class="item-count">25</span>
                              </label>
                           </li>
                           <li class="inputwrapper">
                              <input class="custom-input" type="checkbox" data-name="colorWithNames"
                                 name="dropdown-colorWithNames" id="dropdown-colorWithNames-블랙020202" value="블랙_020202">
                              <label class="label" for="dropdown-colorWithNames-블랙020202">
                                 <span class="item-color" style="background:#020202;"></span>
                                 <span class="text">블랙</span>
                                 <span class="item-count">23</span>
                              </label>
                           </li>
                           <li class="inputwrapper">
                              <input class="custom-input" type="checkbox" data-name="colorWithNames"
                                 name="dropdown-colorWithNames" id="dropdown-colorWithNames-브라운ad6b44" value="브라운_ad6b44">
                              <label class="label" for="dropdown-colorWithNames-브라운ad6b44">
                                 <span class="item-color" style="background:#ad6b44;"></span>
                                 <span class="text">브라운</span>
                                 <span class="item-count">19</span>
                              </label>
                           </li>
                           <li class="inputwrapper">
                              <input class="custom-input" type="checkbox" data-name="colorWithNames"
                                 name="dropdown-colorWithNames" id="dropdown-colorWithNames-그레이a6aaad" value="그레이_a6aaad">
                              <label class="label" for="dropdown-colorWithNames-그레이a6aaad">
                                 <span class="item-color" style="background:#a6aaad;"></span>
                                 <span class="text">그레이</span>
                                 <span class="item-count">17</span>
                              </label>
                           </li>
                           <li class="inputwrapper">
                              <input class="custom-input" type="checkbox" data-name="colorWithNames"
                                 name="dropdown-colorWithNames" id="dropdown-colorWithNames-베이지e1cab2" value="베이지_e1cab2">
                              <label class="label" for="dropdown-colorWithNames-베이지e1cab2">
                                 <span class="item-color" style="background:#e1cab2;"></span>
                                 <span class="text">베이지 / 내추럴</span>
                                 <span class="item-count">13</span>
                              </label>
                           </li>
                           <li class="inputwrapper">
                              <input class="custom-input" type="checkbox" data-name="colorWithNames"
                                 name="dropdown-colorWithNames" id="dropdown-colorWithNames-그린599d64" value="그린_599d64">
                              <label class="label" for="dropdown-colorWithNames-그린599d64">
                                 <span class="item-color" style="background:#599d64;"></span>
                                 <span class="text">그린</span>
                                 <span class="item-count">11</span>
                              </label>
                           </li>
                           <li class="inputwrapper">
                              <input class="custom-input" type="checkbox" data-name="colorWithNames"
                                 name="dropdown-colorWithNames" id="dropdown-colorWithNames-옐로우ffdf1f" value="옐로우_ffdf1f">
                              <label class="label" for="dropdown-colorWithNames-옐로우ffdf1f">
                                 <span class="item-color" style="background:#ffdf1f;"></span>
                                 <span class="text">옐로우</span>
                                 <span class="item-count">10</span>
                              </label>
                           </li>
                           <li class="inputwrapper">
                              <input class="custom-input" type="checkbox" data-name="colorWithNames"
                                 name="dropdown-colorWithNames" id="dropdown-colorWithNames-핑크ff8499" value="핑크_ff8499">
                              <label class="label" for="dropdown-colorWithNames-핑크ff8499">
                                 <span class="item-color" style="background:#ff8499;"></span>
                                 <span class="text">핑크</span>
                                 <span class="item-count">6</span>
                              </label>
                           </li>
                           <li class="inputwrapper">
                              <input class="custom-input" type="checkbox" data-name="colorWithNames"
                                 name="dropdown-colorWithNames" id="dropdown-colorWithNames-퍼플753d9b" value="퍼플_753d9b">
                              <label class="label" for="dropdown-colorWithNames-퍼플753d9b">
                                 <span class="item-color" style="background:#753d9b;"></span>
                                 <span class="text">퍼플</span>
                                 <span class="item-count">3</span>
                              </label>
                           </li>
                           <li class="inputwrapper">
                              <input class="custom-input" type="checkbox" data-name="colorWithNames"
                                 name="dropdown-colorWithNames" id="dropdown-colorWithNames-오렌지da5a23" value="오렌지_da5a23">
                              <label class="label" for="dropdown-colorWithNames-오렌지da5a23">
                                 <span class="item-color" style="background:#da5a23;"></span>
                                 <span class="text">오렌지</span>
                                 <span class="item-count">2</span>
                              </label>
                           </li>
                        </ul>
   
                     </div>
                  </fieldset>
   
                  <fieldset class="dropdown-container  " style="">
                     <legend class="products-filter-group-legend">소재</legend>
                     <button class="dropdown-btn js-dropdownbtn" aria-expanded="false"
                        aria-controls="dropdown-materials">소재<span class="dropdown-btn-toggler"></span></button>
                     <div class="dropdown js-dropdown dropdown-checkbox white-box" id="dropdown-materials"
                        aria-hidden="true">
                        <ul class="dropdown-list">
                           <li class="inputwrapper">
                              <input class="custom-input" type="checkbox" data-name="materials" name="dropdown-materials"
                                 id="dropdown-materials-cashmere" value="cashmere">
                              <label class="label" for="dropdown-materials-cashmere">
                                 <span class="text">캐시미어</span>
                                 <span class="item-count">52</span>
                              </label>
                           </li>
                           <li class="inputwrapper">
                              <input class="custom-input" type="checkbox" data-name="materials" name="dropdown-materials"
                                 id="dropdown-materials-cotton" value="cotton">
                              <label class="label" for="dropdown-materials-cotton">
                                 <span class="text">코튼</span>
                                 <span class="item-count">56</span>
                              </label>
                           </li>
                           <li class="inputwrapper">
                              <input class="custom-input" type="checkbox" data-name="materials" name="dropdown-materials"
                                 id="dropdown-materials-leather" value="leather">
                              <label class="label" for="dropdown-materials-leather">
                                 <span class="text">가죽</span>
                                 <span class="item-count">11</span>
                              </label>
                           </li>
                           <li class="inputwrapper">
                              <input class="custom-input" type="checkbox" data-name="materials" name="dropdown-materials"
                                 id="dropdown-materials-silk" value="silk">
                              <label class="label" for="dropdown-materials-silk">
                                 <span class="text">실크</span>
                                 <span class="item-count">36</span>
                              </label>
                           </li>
                           <li class="inputwrapper">
                              <input class="custom-input" type="checkbox" data-name="materials" name="dropdown-materials"
                                 id="dropdown-materials-wool" value="wool">
                              <label class="label" for="dropdown-materials-wool">
                                 <span class="text">울</span>
                                 <span class="item-count">12</span>
                              </label>
                           </li>
                           <li class="inputwrapper">
                              <input class="custom-input" type="checkbox" data-name="materials" name="dropdown-materials"
                                 id="dropdown-materials-other" value="other">
                              <label class="label" for="dropdown-materials-other">
                                 <span class="text">기타</span>
                                 <span class="item-count">35</span>
                              </label>
                           </li>
                        </ul>
                     </div>
                  </fieldset>
   
                  <fieldset class="dropdown-container  " style="">
                     <legend class="products-filter-group-legend">필터 기준 카테고리</legend>
                     <button class="dropdown-btn js-dropdownbtn" aria-expanded="false"
                        aria-controls="dropdown-categorys">카테고리<span class="dropdown-btn-toggler"></span></button>
                     <div class="dropdown js-dropdown dropdown-checkbox white-box" id="dropdown-categorys"
                        aria-hidden="true">
   
                        <ul class="dropdown-list">
                           <li class="inputwrapper">
                              <input class="custom-input" type="checkbox" data-name="categorys" name="dropdown-categorys"
                                 id="dropdown-categorys-coat-jacket" value="coat-jacket">
                              <label class="label" for="dropdown-categorys-coat-jacket">
                                 <span class="text">코트 &amp; 재킷</span>
                                 <span class="item-count">51</span>
                              </label>
                           </li>
                           <li class="inputwrapper">
                              <input class="custom-input" type="checkbox" data-name="categorys" name="dropdown-categorys"
                                 id="dropdown-categorys-dress-skirt" value="dress-skirt">
                              <label class="label" for="dropdown-categorys-dress-skirt">
                                 <span class="text">드레스 &amp; 스커트</span>
                                 <span class="item-count">51</span>
                              </label>
                           </li>
                           <li class="inputwrapper">
                              <input class="custom-input" type="checkbox" data-name="categorys" name="dropdown-categorys"
                                 id="dropdown-categorys-top-shirt" value="top-shirt">
                              <label class="label" for="dropdown-categorys-top-shirt">
                                 <span class="text">탑 &amp; 셔츠</span>
                                 <span class="item-count">67</span>
                              </label>
                           </li>
                           <li class="inputwrapper">
                              <input class="custom-input" type="checkbox" data-name="categorys" name="dropdown-categorys"
                                 id="dropdown-categorys-pants-shorts" value="pants-shorts">
                              <label class="label" for="dropdown-categorys-pants-shorts">
                                 <span class="text">팬츠 &amp; 쇼츠</span>
                                 <span class="item-count">27</span>
                              </label>
                           </li>
                           <li class="inputwrapper">
                              <input class="custom-input" type="checkbox" data-name="categorys" name="dropdown-categorys"
                                 id="dropdown-categorys-knit-twill" value="knit-twill">
                              <label class="label" for="dropdown-categorys-knit-twill">
                                 <span class="text">니트웨어 &amp; 트윌렌</span>
                                 <span class="item-count">68</span>
                              </label>
                           </li>
                           <li class="inputwrapper">
                              <input class="custom-input" type="checkbox" data-name="categorys" name="dropdown-categorys"
                                 id="dropdown-categorys-casual" value="casual">
                              <label class="label" for="dropdown-categorys-casual">
                                 <span class="text">캐주얼웨어</span>
                                 <span class="item-count">26</span>
                              </label>
                           </li>
                           <li class="inputwrapper">
                              <input class="custom-input" type="checkbox" data-name="categorys" name="dropdown-categorys"
                                 id="dropdown-categorys-beach" value="beach">
                              <label class="label" for="dropdown-categorys-beach">
                                 <span class="text">비치웨어</span>
                                 <span class="item-count">9</span>
                              </label>
                           </li>
                        </ul>
                     </div>
                  </fieldset>
                  <fieldset class="dropdown-container  " style="">
                     <legend class="products-filter-group-legend">필터 기준 사이즈</legend>
                     <button class="dropdown-btn js-dropdownbtn" aria-expanded="false"
                        aria-controls="dropdown-size">사이즈<span class="dropdown-btn-toggler"></span></button>
                     <div class="dropdown js-dropdown dropdown-btns" id="dropdown-size" aria-hidden="true">
                        <ul class="dropdown-list">
                           <li class="inputwrapper"><input class="custom-input" type="button" data-name="size"
                                 name="dropdown-size" id="dropdown-size-34" value="34"></li>
                           <li class="inputwrapper">
                              <input class="custom-input" type="button" data-name="size" name="dropdown-size"
                                 id="dropdown-size-36" value="36">
                           </li>
                           <li class="inputwrapper">
                              <input class="custom-input" type="button" data-name="size" name="dropdown-size"
                                 id="dropdown-size-38" value="38">
                           </li>
                           <li class="inputwrapper">
                              <input class="custom-input" type="button" data-name="size" name="dropdown-size"
                                 id="dropdown-size-40" value="40">
                           </li>
                           <li class="inputwrapper">
                              <input class="custom-input" type="button" data-name="size" name="dropdown-size"
                                 id="dropdown-size-42" value="42">
                           </li>
                           <li class="inputwrapper">
                              <input class="custom-input" type="button" data-name="size" name="dropdown-size"
                                 id="dropdown-size-44" value="44">
                           </li>
                           <li class="inputwrapper">
                              <input class="custom-input" type="button" data-name="size" name="dropdown-size"
                                 id="dropdown-size-os" value="O/S">
                           </li>
                           <li class="inputwrapper">
                              <input class="custom-input" type="button" data-name="size" name="dropdown-size"
                                 id="dropdown-size-32" value="32">
                           </li>
                        </ul>
                     </div>
                  </fieldset>
               </div>

               <div class="show-in-mobile" id="columSettingBox">
                  <input class="hidden" type="radio" id="two" name="column" value="two" checked>
                  <label for="two" class="hidden">two line</label>
                  <input class="hidden" type="radio" id="one" name="column" value="one" >
                  <label for="one" class="hidden">one line</label>
                  <button class="columnSetting" id="twoVisibleBtn"><div class="columnSettingInner"></div></button>
                  <button class="columnSetting" id="oneVisibleBtn"><div class="columnSettingInner"></div></button>
               </div>

               <div class="flex-right right-sort-box" id="sortBtn">
                  
                  <span _ngcontent-hermes-c2018250484="" class="form-item-select-label-wrapper"><label
                        _ngcontent-hermes-c2018250484="" class="form-sort-label" for="result-sort-by">정렬 기준</label><select
                        _ngcontent-hermes-c2018250484="" id="result-sort-by" name="sortby"
                        aria-describedby="refresh-grid-notify" class="ng-pristine ng-valid ng-touched">
                        <option _ngcontent-hermes-c2018250484="" value="0: Object" selected="true"
                           class="ng-star-inserted"> 관련성 </option>
                        <option _ngcontent-hermes-c2018250484="" value="1: Object" class="ng-star-inserted"> 낮은 가격순
                        </option>
                        <option _ngcontent-hermes-c2018250484="" value="2: Object" class="ng-star-inserted"> 높은 가격순
                        </option><!---->
                     </select>
                     <span class="current-sort" aria-hidden="true"> 관련성 </span>
                     <span class="dropdown-btn-toggler"></span>
                  </span>
               </div>
            </form>
         </div>
      </div>
      
      <div class="prd-list twoLine">
         
         <!-- 
         <a href="" class="prd-item">
            <div class="prd-image"><img src="product/1-1.webp"></div>
            <div class="prd-carousel" data-imagesurl="1-1.webp, 1-2.webp, 1-3.webp, 1-4.webp">
               
               <div class="wrap">
                  <div class="swiperWrap">
                     <div class="swiper mySwiper">
                        <div class="swiper-wrapper" centered-slides="true">
                           <div class="swiper-slide"><img src="product/1-1.webp" alt=""></div>
                           <div class="swiper-slide"><img src="product/1-2.webp" alt=""></div>
                           <div class="swiper-slide"><img src="product/1-3.webp" alt=""></div>
                           <div class="swiper-slide"><img src="product/1-4.webp" alt=""></div>  
                        </div>           
                        <div class="swiper-button-next"></div>
                        <div class="swiper-button-prev"></div>
                     </div>
                  </div>
               </div>
            </div>
            <div class="prd-meta">
               <p class="prd-name">셔츠 드레스</p>
               <p class="prd-color sr-only">, 컬러 : 화이트</p>
               <p class="prd-price"><span class="sr-only">, </span>₩ 2,980,000</p>
            </div>
         </a>
         <a href="detail.html" class="prd-item">
            <div class="prd-image"><img src="product/2-1.webp"></div>
            <div class="prd-carousel" data-imagesurl="2-1.webp,2-2.webp,2-3.webp"></div>
            <div class="prd-meta">
               <p class="prd-name">“Mosaique” 지퍼 셔츠 드레스</p>
               <p class="prd-color sr-only">, 컬러 : 화이트</p>
               <p class="prd-price"><span class="sr-only">, </span>₩ 3,810,000</p>
            </div>
         </a>
         <a href="detail.html" class="prd-item">
            <div class="prd-image"><img src="product/3-1.webp"></div>
            <div class="prd-carousel" data-imagesurl="3-1.webp,3-2.jfif,3-3.webp"></div>
            <div class="prd-meta">
               <p class="prd-name">“Della Cavalleria” 티셔츠 드레스</p>
               <p class="prd-color sr-only">, 컬러 : 화이트</p>
               <p class="prd-price"><span class="sr-only">, </span>₩ 960,000</p>
            </div>
         </a>
         <a href="detail.html" class="prd-item">
            <div class="prd-image"><img src="product/4-1.webp"></div>
            <div class="prd-carousel" data-imagesurl="4-1.webp,4-2.webp,4-3.webp"></div>
            <div class="prd-meta">
               <p class="prd-name">“Chaine d'Ancre” 스웨트셔츠</p>
               <p class="prd-color sr-only">, 컬러:  브라운</p>
               <p class="prd-price"><span class="sr-only">, </span>₩ 1,460,000</p>
            </div>
         </a>
         <a href="#" class="prd-item prd-item-large">
            <div class="prd-image"><img src="product/24-1.webp"></div>
            <div class="prd-carousel" data-imagesurl="24-1.webp,24-2.webp,24-3.webp,24-4.webp"></div>
            <div class="prd-meta">
               <p class="prd-name">“Chaine d'Ancre” 미니스커트<span class="enlarge grid-right"></span></p>
               <p class="prd-color sr-only">, 컬러:  브라운</p>
               <p class="prd-price"><span class="sr-only">, </span>₩ 1,410,000</p>
            </div>
         </a>
         <a href="detail.html" class="prd-item">
            <div class="prd-image"><img src="product/5-1.webp"></div>
            <div class="prd-carousel" data-imagesurl="5-1.webp,5-2.webp"></div>
            <div class="prd-meta">
               <p class="prd-name">“Chaine d'Ancre” 조깅 팬츠</p>
               <p class="prd-color sr-only">, 컬러:  브라운</p>
               <p class="prd-price"><span class="sr-only">, </span>₩ 2,070,000</p>
            </div>
         </a>
         <a href="detail.html" class="prd-item">
            <div class="prd-image"><img src="product/6-1.webp"></div>
            <div class="prd-carousel" data-imagesurl="6-1.webp,6-2.webp,6-3.webp,6-4.webp"></div>
            <div class="prd-meta">
               <p class="prd-name">루즈 핏 팬츠</p>
               <p class="prd-color sr-only">, 컬러 : 화이트</p>
               <p class="prd-price"><span class="sr-only">, </span>₩ 1,820,000</p>
            </div>
         </a>
         <a href="detail.html" class="prd-item">
            <div class="prd-image"><img src="product/7-1.jfif"></div>
            <div class="prd-carousel" data-imagesurl="7-1.jfif,7-2.webp,7-3.webp"></div>
            <div class="prd-meta">
               <p class="prd-name">“Naoussa” 롱 가디건</p>
               <p class="prd-color sr-only">, 컬러:  레드</p>
               <p class="prd-price"><span class="sr-only">, </span>₩ 3,810,000</p>
            </div>
         </a>
         <a href="detail.html" class="prd-item">
            <div class="prd-image"><img src="product/8-1.webp"></div>
            <div class="prd-carousel" data-imagesurl="8-1.webp,8-2.webp,8-3.webp"></div>
            <div class="prd-meta">
               <p class="prd-name">“Della Cavalleria” 티셔츠</p>
               <p class="prd-color sr-only">, 컬러:  레드</p>
               <p class="prd-price"><span class="sr-only">, </span>₩ 850,000</p>
            </div>
         </a>
         <a href="detail.html" class="prd-item">
            <div class="prd-image"><img src="product/9-1.jfif"></div>
            <div class="prd-carousel" data-imagesurl="9-1.jfif,9-2.webp,9-3.webp"></div>
            <div class="prd-meta">
               <p class="prd-name">“Della Cavalleria” 티셔츠 드레스</p>
               <p class="prd-color sr-only">, 컬러:  레드</p>
               <p class="prd-price"><span class="sr-only">, ₩ 960,000</span></p>
            </div>
         </a>
         <a href="detail.html" class="prd-item">
            <div class="prd-image"><img src="product/10-1.webp"></div>
            <div class="prd-carousel" data-imagesurl="10-1.webp,10-2.webp,10-3.webp,10-4.webp,105.webp"></div>
            <div class="prd-meta">
               <p class="prd-name">드로스트링 튜닉</p>
               <p class="prd-color sr-only">, 컬러:  레드</p>
               <p class="prd-price"><span class="sr-only">, </span>₩ 2,980,000</p>
            </div>
         </a>
         <a href="#" class="prd-item prd-item-large">
            <div class="prd-image"><img src="product/11-1.jfif"></div>
            <div class="prd-carousel" data-imagesurl="11-1.jfif,11-2.webp"></div>
            <div class="prd-meta">
               <p class="prd-name">“En Roue Libre” 비치 튜닉<span class="enlarge grid-left"></span></p>
               <p class="prd-color sr-only">, 컬러:  레드</p>
               <p class="prd-price"><span class="sr-only">, </span>₩ 2,490,000</p>
            </div>
         </a>
         <a href="detail.html" class="prd-item">
            <div class="prd-image"><img src="product/12-1.webp"></div>
            <div class="prd-carousel" data-imagesurl="12-1.webp,12-2.webp,12-3.webp"></div>
            <div class="prd-meta">
               <p class="prd-name">Christina 수영복</p>
               <p class="prd-color sr-only">, 컬러:  레드</p>
               <p class="prd-price"><span class="sr-only">, </span>₩ 780,000</p>
            </div>
         </a>
         <a href="detail.html" class="prd-item">
            <div class="prd-image"><img src="product/13-1.webp"></div>
            <div class="prd-carousel" data-imagesurl="13-1.webp,13-2.webp,13-3.webp"></div>
            <div class="prd-meta">
               <p class="prd-name">“En Roue Libre” 맥시 티셔츠</p>
               <p class="prd-color sr-only">, 컬러:  레드</p>
               <p class="prd-price"><span class="sr-only">, </span>₩ 1,090,000</p>
            </div>
         </a>
         <a href="detail.html" class="prd-item">
            <div class="prd-image"><img src="product/14-1.webp"></div>
            <div class="prd-carousel" data-imagesurl="14-1.webp,14-2.webp,14-3.webp"></div>
            <div class="prd-meta">
               <p class="prd-name">Christina 수영복</p>
               <p class="prd-color sr-only">, 컬러:  블루</p>
               <p class="prd-price"><span class="sr-only">, </span>₩ 780,000</p>
            </div>
         </a>
         <a href="detail.html" class="prd-item">
            <div class="prd-image"><img src="product/15-1.webp"></div>
            <div class="prd-carousel" data-imagesurl="15-1.webp,15-2.webp"></div>
            <div class="prd-meta">
               <p class="prd-name">“Panoplie Tout Cuir” 플리츠 쇼트 스커트</p>
               <p class="prd-color sr-only">, 컬러:  블루</p>
               <p class="prd-price"><span class="sr-only">, </span>₩ 2,980,000</p>
            </div>
         </a>
         <a href="detail.html" class="prd-item">
            <div class="prd-image"><img src="product/16-1.webp"></div>
            <div class="prd-carousel" data-imagesurl="16-1.webp,16-2.webp,16-3.webp,16-4.webp"></div>
            <div class="prd-meta">
               <p class="prd-name">캐시미어 코트</p>
               <p class="prd-color sr-only">, 컬러:  블랙</p>
               <p class="prd-price"><span class="sr-only">, </span>₩ 14,090,000</p>
            </div>
         </a>
         <a href="detail.html" class="prd-item">
            <div class="prd-image"><img src="product/17-1.webp"></div>
            <div class="prd-carousel" data-imagesurl="17-1.webp,17-2.webp,17-3.webp"></div>
            <div class="prd-meta">
               <p class="prd-name">Claudia 수영복</p>
               <p class="prd-color sr-only">, 컬러:  블랙</p>
               <p class="prd-price"><span class="sr-only">, </span>₩ 780,000</p>
            </div>
         </a>
         <a href="detail.html" class="prd-item">
            <div class="prd-image"><img src="product/18-1.webp"></div>
            <div class="prd-carousel" data-imagesurl="18-1.webp,18-2.webp,18-3.webp"></div>
            <div class="prd-meta">
               <p class="prd-name">“En Roue Libre” 비치 튜닉</p>
               <p class="prd-color sr-only">, 컬러:  블루</p>
               <p class="prd-price"><span class="sr-only">, </span>₩ 2,490,000</p>
            </div>
         </a>
         <a href="detail.html" class="prd-item">
            <div class="prd-image"><img src="product/19-1.webp"></div>
            <div class="prd-carousel" data-imagesurl="19-1.webp,19-2.webp,19-3.webp"></div>
            <div class="prd-meta">
               <p class="prd-name">“Panoplie Tout Cuir Jersey” 스트레이트 티셔츠</p>
               <p class="prd-color sr-only">, 컬러:  블루</p>
               <p class="prd-price"><span class="sr-only">, </span>₩ 930,000</p>
            </div>
         </a>
         <a href="#" class="prd-item prd-item-large">
            <div class="prd-image"><img src="product/20-1.webp"></div>
            <div class="prd-carousel" data-imagesurl="20-1.webp,20-2.webp,20-3.webp"></div>
            <div class="prd-meta">
               <p class="prd-name">“Panoplie Tout Cuir” 쇼트 슬리브 트윌렌 스웨터<span class="enlarge grid-right"></span></p>
               <p class="prd-color sr-only">, 컬러:  블루</p>
               <p class="prd-price"><span class="sr-only">, </span>₩ 3,980,000</p>
            </div>
         </a>
         <a href="detail.html" class="prd-item">
            <div class="prd-image"><img src="product/21-1.webp"></div>
            <div class="prd-carousel" data-imagesurl="21-1.webp,21-2.webp,21-3.webp,21-4.webp"></div>
            <div class="prd-meta">
               <p class="prd-name">캐럿 팬츠</p>
               <p class="prd-color sr-only">, 컬러:  블랙</p>
               <p class="prd-price"><span class="sr-only">, </span>₩ 2,490,000</p>
            </div>
         </a>
         <a href="detail.html" class="prd-item">
            <div class="prd-image"><img src="product/22-1.webp"></div>
            <div class="prd-carousel" data-imagesurl="22-1.webp,22-2.webp,22-3.webp"></div>
            <div class="prd-meta">
               <p class="prd-name">“Della Cavalleria” 티셔츠</p>
               <p class="prd-color sr-only">, 컬러:  블루</p>
               <p class="prd-price"><span class="sr-only">, </span>₩ 850,000</p>
            </div>
         </a>
         <a href="detail.html" class="prd-item">
            <div class="prd-image"><img src="product/23-1.webp"></div>
            <div class="prd-carousel" data-imagesurl="23-1.webp,23-2.webp,23-3.webp"></div>
            <div class="prd-meta">
               <p class="prd-name">“Della Cavalleria” 티셔츠 드레스</p>
               <p class="prd-color sr-only">, 컬러:  블루</p>
               <p class="prd-price"><span class="sr-only">, </span>₩ 960,000</p>
            </div>
         </a> -->
      </div>
      <div class="moreBtn">더 많은 상품 보기</div>
   </main>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>