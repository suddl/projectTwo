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
	
	String productName=Utility.escapeTag(multipartRequest.getParameter("productName"));
	int productPrice=Integer.parseInt(multipartRequest.getParameter("productPrice"));
	String productCategory=Utility.escapeTag(multipartRequest.getParameter("productCategory"));
	
	if(productCategory.equals("Nail")){
		productCategory="Nail";
	} else if(productCategory.equals("Pedi")){
		productCategory="Pedi";
	} else if(productCategory.equals("CareTool")){
		productCategory="CareTool";
	}
	
	String productType=Utility.escapeTag(multipartRequest.getParameter("productType"));
	
	if(productType.equals("Long")){
		productType="Long";
	} else if(productType.equals("Short")){
		productType="Short";
	} else if(productType.equals("Parts")){
		productType="Parts";
	} else if(productType.equals("FullColor")){
		productType="FullColor";
	}
	
	String productImage=multipartRequest.getFilesystemName("productImage");
	if(productImage!=null) {
		productImage="/product_images/"+productImage;
		
		String removeProductImage=ProductDAO.getDAO().selectProductByNum(productNum).getProductImage();
		if(removeProductImage!=null) {
			new File(saveDirectory, removeProductImage.substring("/product_images/".length())).delete();
		}
	}
	
	String productImage2=multipartRequest.getFilesystemName("productImage2");
	if(productImage2!=null) {
		productImage2="/product_images/"+productImage2;
		
		String removeProductImage2=ProductDAO.getDAO().selectProductByNum(productNum).getProductImage2();
		if(removeProductImage2!=null) {
			new File(saveDirectory, removeProductImage2.substring("/product_images/".length())).delete();
		}
	}
	
	String productImage3=multipartRequest.getFilesystemName("productImage3");
	if(productImage!=null) {
		productImage="/product_images/"+productImage;
		
		String removeProductImage3=ProductDAO.getDAO().selectProductByNum(productNum).getProductImage3();
		if(removeProductImage3!=null) {
			new File(saveDirectory, removeProductImage3.substring("/product_images/".length())).delete();
		}
	}
	
	ProductDTO product=new ProductDTO();
	product.setProductNum(productNum);
	product.setProductName(productName);
	product.setProductImage(productImage);
	product.setProductImage2(productImage2);
	product.setProductImage3(productImage3);
	product.setProductPrice(productPrice);
	product.setProductCategory(productCategory);
	product.setProductType(productType);
	
	ProductDAO.getDAO().updateProduct(product);
	
	request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=admin&worker=product_detail"
			+"&productNum="+productNum+"&pageNum="+pageNum+"&pageSize="+pageSize+"&search="+search+"&keyword="+keyword);
%>