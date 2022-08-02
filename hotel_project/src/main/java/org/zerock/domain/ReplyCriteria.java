package org.zerock.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
public class ReplyCriteria {
	private int pageNum;
	private int amount;

	

	public ReplyCriteria() {
		this(1,10);
	}
	
	
	public ReplyCriteria(int pageNum, int amount) {
		
		this.pageNum = pageNum;
		this.amount = amount;
	}
	


	

	public String getListLink() {

		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount());
				

		return builder.toUriString();

	}


}
