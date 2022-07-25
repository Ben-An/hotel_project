package org.zerock.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
public class Criteria {
	private int pageNum;
	private int amount;
	private String keyword;
	
	
	//public Criteria() { this(1, 10); }
	
	
	/*
	 * public Criteria(int pageNum, int amount) { this.pageNum = pageNum;
	 * this.amount = amount; }
	 */
	public Criteria(String keyword) {
		this.keyword = keyword;
	}
}
