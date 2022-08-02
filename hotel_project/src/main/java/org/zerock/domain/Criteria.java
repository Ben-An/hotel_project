package org.zerock.domain;

import lombok.Data;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@Data
public class Criteria {
	private int pageNum;
	private int amount;
	private String keyword;
	
	
	public Criteria() { 
		
	}
	
	
	/*
	 * public Criteria(int pageNum, int amount) { this.pageNum = pageNum;
	 * this.amount = amount; }
	 */
	public Criteria(String keyword) {
		this.keyword = keyword;
	}
}
