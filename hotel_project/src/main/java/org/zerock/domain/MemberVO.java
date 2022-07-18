package org.zerock.domain;

public class MemberVO {
	private int memberNo;
	private String memberId;
	private String memberPassword;
	private String memberName;
	private String memberNickname;
	private String memberEmail;
	private String memberPhoneNo;
	private String memberGender;
	
	
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getMemberPassword() {
		return memberPassword;
	}
	public void setMemberPassword(String memberPassword) {
		this.memberPassword = memberPassword;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getMemberNickname() {
		return memberNickname;
	}
	public void setMemberNickname(String memberNickname) {
		this.memberNickname = memberNickname;
	}
	public String getMemberEmail() {
		return memberEmail;
	}
	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}
	public String getMemberPhoneNo() {
		return memberPhoneNo;
	}
	public void setMemberPhoneNo(String memberPhoneNo) {
		this.memberPhoneNo = memberPhoneNo;
	}
	public String isMemberGender() {
		return memberGender;
	}
	public void setMemberGender(String memberGender) {
		this.memberGender = memberGender;
	}
	@Override
	public String toString() {
		return "MemberVO [memberNo=" + memberNo + ", memberId=" + memberId + ", memberPassword=" + memberPassword
				+ ", memberName=" + memberName + ", memberNickname=" + memberNickname + ", memberEmail=" + memberEmail
				+ ", memberPhoneNo=" + memberPhoneNo + ", memberGender=" + memberGender + "]";
	}
	
	
}
