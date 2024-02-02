<%@page import="xyz.nailro.util.Utility"%>
<%@page import="xyz.nailro.dto.ProductDTO"%>
<%@page import="xyz.nailro.dao.ProductDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 상품글을 전달받아 PRODUCT 테이블의 행으로 삽입하고 [/admin/product_list.jsp]
문서를 요청하기 위한 URL 주소를 전달하여 응답하기 위한 JSP 문서 - 페이징 처리 관련 값 전달 --%>
<%-- => 관리자만 요청 가능한 JSP 문서 --%>
<%-- => 게시글이 [multipart/form-data] 타입으로 전달되므로 COS 라이브러리의 MultipartRequest 객체를 사용하여 처리 --%>
<%-- => 전달받은 파일은 [/review_images] 서버 디렉터리에 저장되도록 업로드 처리 --%>
<%
	//JSP 문서를 GET 방식으로 요청한 경우에 대한 응답 처리 - 비정상적인 요청
	if(request.getMethod().equals("GET")) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}

	//전달파일을 저장할 서버 디렉토리의 파일 시스템 경로를 반환받아 저장
	String saveDirectory=request.getServletContext().getRealPath("/images");
	
	//MultipartRequest 객체 생성 - 모든 전달파일을 서버 디렉터리에 저장되도록 자동 업로드 처리
	// => cos.jar 라이브러리 파일을 프로젝트에 빌드 처리해야만 MultipartRequest 클래스 사용 가능
	MultipartRequest multipartRequest=new MultipartRequest(request, saveDirectory
			, 20*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	
	//전달값을 반환받아 저장
	String pageNum=multipartRequest.getParameter("pageNum");
	String pageSize=multipartRequest.getParameter("pageSize");
	String search=multipartRequest.getParameter("search");
	String keyword=multipartRequest.getParameter("keyword");
	
	String productName=Utility.escapeTag(multipartRequest.getParameter("productName"));
	int productPrice=Integer.parseInt(multipartRequest.getParameter("productPrice"));
	String productCategory=Utility.escapeTag(multipartRequest.getParameter("productCategory"));
	String productType=Utility.escapeTag(multipartRequest.getParameter("productType"));
	
	//서버 디렉토리에 업로드되어 저장된 파일명을 반환받아 컨텍스트 경로를 저장
	String productImage=null;
	if(multipartRequest.getFilesystemName("productImage")!=null) {//업로드 파일이 있는 경우	
		productImage="/images/"+multipartRequest.getFilesystemName("productImage");
	}
	String productImage2=null;
	if(multipartRequest.getFilesystemName("productImage2")!=null) {//업로드 파일이 있는 경우	
		productImage="/images/"+multipartRequest.getFilesystemName("productImage2");
	}
	String productImage3=null;
	if(multipartRequest.getFilesystemName("productImage3")!=null) {//업로드 파일이 있는 경우	
		productImage="/images/"+multipartRequest.getFilesystemName("productImage3");
	}
	
	//PRODUCT_SEQ 시퀸스의 다음값을 검색하여 반환하는 ProductDAO 클래스의 메소드 호출
	int nextNum=ProductDAO.getDAO().selectProductNextNum();
	
	//ProductDTO 객체를 생성하여 변수값(전달값)으로 필드값 변경
	ProductDTO product=new ProductDTO();
	product.setProductNum(nextNum);//시퀸스 객체의 다음값으로 필드값 변경
	product.setProductName(productName);
	product.setProductImage(productImage);
	product.setProductImage2(productImage2);
	product.setProductImage3(productImage3);
	product.setProductPrice(productPrice);
	product.setProductCategory(productCategory);
	product.setProductType(productType);
	
	//상품글을 전달받아 PRODUCT 테이블의 행으로 삽입하고 삽입행의 갯수를 반환하는 ProductDAO 클래스의 메소드 호출
	ProductDAO.getDAO().insertProduct(product);
	
	//페이지 이동 - 검색 및 페이징 처리 관련 값 전달
	request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=admin&worker=product_list"
		+"&pageNum="+pageNum+"&pageSize="+pageSize+"&search="+search+"&keyword="+keyword);
%>