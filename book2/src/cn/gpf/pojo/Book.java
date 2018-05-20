package cn.gpf.pojo;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class Book {
	
	private Integer id;
	
	private String name;
	
	private String description;
	
	private String author;
	
	private String type;
	
	private Double price;
	
	private Boolean isBorrow;//true为被借走
	
	private Date publicationDate;//出版日期
	
	private Set<Record> bookRecords=new HashSet<Record>();
	
	private User bookUser;
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public Boolean getIsBorrow() {
		return isBorrow;
	}

	public void setIsBorrow(Boolean isBorrow) {
		this.isBorrow = isBorrow;
	}

	public Date getPublicationDate() {
		return publicationDate;
	}

	public void setPublicationDate(Date publicationDate) {
		this.publicationDate = publicationDate;
	}

	public Set<Record> getBookRecords() {
		return bookRecords;
	}

	public void setBookRecords(Set<Record> bookRecords) {
		this.bookRecords = bookRecords;
	}

	public User getBookUser() {
		return bookUser;
	}

	public void setBookUser(User bookUser) {
		this.bookUser = bookUser;
	}



	
	
	

}
