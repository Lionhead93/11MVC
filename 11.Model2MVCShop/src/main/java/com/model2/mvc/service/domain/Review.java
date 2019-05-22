package com.model2.mvc.service.domain;

import java.sql.Date;

public class Review {
	
	private int reviewNo;
	private int reviewProdNo;
	private int reviewTranNo;
	private int score;
	private String review;
	private Date regDate;
	private String userId;
	
	public Review() {
		// TODO Auto-generated constructor stub
	}

	public int getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}

	public int getReviewProdNo() {
		return reviewProdNo;
	}

	public void setReviewProdNo(int reviewProdNo) {
		this.reviewProdNo = reviewProdNo;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public String getReview() {
		return review;
	}

	public void setReview(String review) {
		this.review = review;
	}
	
	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public int getReviewTranNo() {
		return reviewTranNo;
	}

	public void setReviewTranNo(int reviewTranNo) {
		this.reviewTranNo = reviewTranNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	@Override
	public String toString() {
		return "Review [reviewNo=" + reviewNo + ", reviewProdNo=" + reviewProdNo + ", reviewTranNo=" + reviewTranNo
				+ ", score=" + score + ", review=" + review + ", regDate=" + regDate + ", userId=" + userId + "]";
	}
}
