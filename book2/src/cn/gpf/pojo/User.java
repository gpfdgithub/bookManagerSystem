package cn.gpf.pojo;

import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

public class User {
	
	private Integer id;
	private String username;
	private String password;
	
	public static Integer maxAdmitBorrowCount=6;//最大允许借走书的数量

	private String telphoneNumber;
	
	private Set<Book> books=new HashSet<Book>();
	
	private Set<Record> records=new HashSet<Record>();
	
	
	public String getTelphoneNumber() {
		return telphoneNumber;
	}
	public void setTelphoneNumber(String telphoneNumber) {
		this.telphoneNumber = telphoneNumber;
	}
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Set<Book> getBooks() {
		return books;
	}
	public void setBooks(Set<Book> books) {
		this.books = books;
	}
	public Set<Record> getRecords() {
		return records;
	}
	public void setRecords(Set<Record> records) {
		this.records = records;
	}
	
	
	
	

}
