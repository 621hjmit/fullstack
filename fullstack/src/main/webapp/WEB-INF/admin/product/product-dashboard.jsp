<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/admin/common/header.jsp" %>
    <!-- [ Main Content ] start -->
    <div class="pc-container">
      <div class="pc-content">
        <!-- [ breadcrumb ] start -->
        <div class="page-header">
          <div class="page-block">
            <div class="row align-items-center">
              <div class="col-md-12">
                <div class="page-header-title">
                  <h2 class="mb-0">상품 대쉬보드</h2>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- [ breadcrumb ] end -->
        <!-- [ Main Content ] start -->
        <div class="row">
          <!-- [ sample-page ] start -->
          <div class="col-sm-2 mb-5">
			      <select class="form-select" aria-label="Default select example">
					    <option selected>제품명</option>
					    <option value="1">제품코드</option>
					  </select>
				  </div>
				  <div class="col-sm-10">
				  	<div class="input-group mb-3">
					    <input type="text" class="form-control" placeholder="20210708-0000012" aria-label="Recipient's username" aria-describedby="button-addon2">
							<button class="btn btn-outline-secondary pc-micon" type="button" id="button-addon2"><i class="ph-duotone ph-magnifying-glass"></i></button>
					  </div>
					  <div class="text-end p-sm-4 pb-sm-2">
                    <a href="/application/ecom_product-add.html" class="btn btn-primary"> <i class="ti ti-plus f-18"></i> Add Product </a>
                  </div>
				  </div>
				  
				  
				  
          <div class="col-sm-12">
          
            <div class="card table-card">
            
              <div class="card-body">
                  
                  <table class="table table-hover tbl-product" id="pc-dt-simple">
                    <thead>
                      <tr>
                        <th class="text-end">#</th>
                        <th>상품 정보</th>
                        <th>카테고리</th>
                        <th class="text-end">가격</th>
                        <th class="text-end">재고</th>
                        <th>온라인구매가능</th>
                        <th class="text-center">상태</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>
                        <td class="text-end">7</td>
                        <td>
                          <div class="row">
                            <div class="col-auto pe-0">
                              <img src="/assets/images/application/img-prod-1.jpg" alt="user-image" class="wid-40 rounded" >
                            </div>
                            <div class="col">
                              <h6 class="mb-1">Apple Series 4 GPS A38 MM Space</h6>
                              <p class="text-muted f-12 mb-0">Apple Watch SE Smartwatch </p>
                            </div>
                          </div>
                        </td>
                        <td>Electronics, Laptop</td>
                        <td class="text-end">$14.59</td>
                        <td class="text-end">70</td>
                        <td class="text-center">
                          <i class="ph-duotone ph-check-circle text-success f-24" data-bs-toggle="tooltip" data-bs-title="success"></i>
                        </td>
                        <td class="text-center">
                          <div class="prod-action-links">
                            <ul class="list-inline me-auto mb-0">
                              <li class="list-inline-item align-bottom" data-bs-toggle="tooltip" title="View">
                                <a
                                  href="#"
                                  class="avtar avtar-xs btn-link-secondary btn-pc-default"
                                  data-bs-toggle="offcanvas"
                                  data-bs-target="#productOffcanvas"
                                >
                                  <i class="ti ti-eye f-18"></i>
                                </a>
                              </li>
                              <li class="list-inline-item align-bottom" data-bs-toggle="tooltip" title="Edit">
                                <a href="/application/ecom_product-add.html" class="avtar avtar-xs btn-link-success btn-pc-default">
                                  <i class="ti ti-edit-circle f-18"></i>
                                </a>
                              </li>
                              <li class="list-inline-item align-bottom" data-bs-toggle="tooltip" title="Delete">
                                <a href="#" class="avtar avtar-xs btn-link-danger btn-pc-default">
                                  <i class="ti ti-trash f-18"></i>
                                </a>
                              </li>
                            </ul>
                          </div>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </div>
          <!-- [ sample-page ] end -->
        </div>
        <!-- [ Main Content ] end -->
      </div>
    </div>
    <!-- [ Main Content ] end -->
    <!-- [Page Specific JS] start -->
    <script src="/assets/js/plugins/simple-datatables.js"></script>
    <script>
      const dataTable = new simpleDatatables.DataTable('#pc-dt-simple', {
        sortable: false,
        perPage: 5
      });
    </script>
    <!-- [Page Specific JS] end -->
    
<%@ include file="/WEB-INF/admin/common/footer.jsp" %>