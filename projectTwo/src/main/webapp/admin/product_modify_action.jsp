<%@page import="java.io.File"%>
<%@page import="xyz.nailro.dao.ProductDAO"%>
<%@page import="xyz.nailro.dto.ProductDTO"%>
<%@page import="xyz.nailro.util.Utility"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/admin_check.jspf"%>    

<%
	if(request.getMethod().equals("GET")) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}
	String saveDirectory=request.getServletContext().getRealPath("/product_images");
	
	MultipartRequest multipartRequest = new MultipartRequest(request, saveDirectory, 20*1024*1024,"utf-8", new DefaultFileRenamePolicy());
	
	int productNum=Integer.parseInt(multipartRequest.getParameter("productNum"));
	String pageNum=multipartRequest.getParameter("pageNum");
	String pageSize=multipartRequest.getParameter("pageSize");
	String search=multipartRequest.getParameter("search");
	String keyword=multipartRequest.getParameter("keyword");
	String currentProductImage=multipartRequest.getParameter("currentProductImage");
	String currentProductImage2=multipartRequest.getParameter("currentProductImage2");
	String currentProductImage3=multipartRequest.getParameter("currentProductImage3");
	String productName=multipartRequest.getParameter("productName");
	int productPrice=Integer.parseInt(multipartRequest.getParameter("productPrice"));
	String productCategory=multipartRequest.getParameter("productCategory");
	
	if(productCategory.equals("Nail")){
		productCategory="Nail";
	} else if(productCategory.equals("Pedi")){
		productCategory="Pedi";
	} else if(productCategory.equals("CareTool")){
		productCategory="CareTool";
	}
	
	String productType=multipartRequest.getParameter("productType");
	
	if(productType.equals("롱")){
		productType="Long";
	} else if(productType.equals("숏")){
		productType="Short";
	} else if(productType.equals("파츠")){
		productType="Parts";
	} else if(productType.equals("풀컬러")){
		productType="FullColor";
	} else if(productType.equals("--선택--")){
		productType="";
	} 
	
	String productImage=null;
	if(multipartRequest.getFilesystemName("productImage")!=null) {//업로드 파일이 있는 경우	
		productImage="/product_images/"+multipartRequest.getFilesystemName("productImage");
	}
	String productImage2=null;
	if(multipartRequest.getFilesystemName("productImage2")!=null) {//업로드 파일이 있는 경우	
		productImage2="/product_images/"+multipartRequest.getFilesystemName("productImage2");
	}
	String productImage3=null;
	if(multipartRequest.getFilesystemName("productImage3")!=null) {//업로드 파일이 있는 경우	
		productImage3="/product_images/"+multipartRequest.getFilesystemName("productImage3");
	}

	ProductDTO product=new ProductDTO();
	product.setProductNum(productNum);
	product.setProductName(productName);
	if(productImage==null) {
		product.setProductImage(currentProductImage);
	} else {
		product.setProductImage(productImage);
		new File(saveDirectory, currentProductImage).delete();
	}
	if(productImage2==null) {
		product.setProductImage2(currentProductImage2);
	} else {
		product.setProductImage2(productImage2);
		new File(saveDirectory, currentProductImage2).delete();
	}
	if(productImage3==null) {
		product.setProductImage3(currentProductImage3);
	} else {
		product.setProductImage3(productImage3);
		new File(saveDirectory, currentProductImage3).delete();
	}
	product.setProductPrice(productPrice);
	product.setProductCategory(productCategory);
	product.setProductType(productType);
	
	ProductDAO.getDAO().updateProduct(product);
	
	request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=admin&worker=product_detail"
			+"&productNum="+productNum+"&pageNum="+pageNum+"&pageSize="+pageSize+"&search="+search+"&keyword="+keyword);
%>