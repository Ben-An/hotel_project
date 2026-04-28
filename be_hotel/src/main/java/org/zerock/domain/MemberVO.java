package org.zerock.domain;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.zerock.domain.validation.ValidationGroups.Delete;
import org.zerock.domain.validation.ValidationGroups.Join;
import org.zerock.domain.validation.ValidationGroups.Login;
import org.zerock.domain.validation.ValidationGroups.Update;

public class MemberVO {
	private int memberNo;

	@NotBlank(message = "아이디를 입력해주세요", groups = {Join.class, Login.class, Delete.class})
	@Size(min = 4, max = 20, message = "아이디는 4~20자여야 합니다", groups = {Join.class})
	@Pattern(regexp = "^[a-zA-Z0-9]+$", message = "아이디는 영문과 숫자만 가능합니다", groups = {Join.class})
	private String memberId;

	@NotBlank(message = "비밀번호를 입력해주세요", groups = {Join.class, Login.class, Delete.class})
	@Size(min = 8, max = 20, message = "비밀번호는 8~20자여야 합니다", groups = {Join.class})
	private String memberPassword;

	@NotBlank(message = "이름을 입력해주세요", groups = {Join.class})
	@Size(min = 2, max = 30, message = "이름은 2~30자여야 합니다", groups = {Join.class})
	private String memberName;

	@NotBlank(message = "닉네임을 입력해주세요", groups = {Join.class, Update.class})
	@Size(min = 2, max = 20, message = "닉네임은 2~20자여야 합니다", groups = {Join.class, Update.class})
	private String memberNickname;

	@NotBlank(message = "이메일을 입력해주세요", groups = {Join.class})
	@Email(message = "올바른 이메일 형식이 아닙니다", groups = {Join.class})
	private String memberEmail;

	@NotBlank(message = "전화번호를 입력해주세요", groups = {Join.class})
	@Pattern(regexp = "^01[016789]-\\d{3,4}-\\d{4}$", message = "올바른 전화번호 형식이 아닙니다 (예: 010-1234-5678)", groups = {Join.class})
	private String memberPhoneNo;

	@NotBlank(message = "성별을 선택해주세요", groups = {Join.class})
	@Pattern(regexp = "^[MF]$", message = "성별은 M 또는 F여야 합니다", groups = {Join.class})
	private String memberGender;

	private String memberRole;

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
	public String getMemberGender() {
		return memberGender;
	}
	public void setMemberGender(String memberGender) {
		this.memberGender = memberGender;
	}
	public String getMemberRole() {
		return memberRole;
	}
	public void setMemberRole(String memberRole) {
		this.memberRole = memberRole;
	}
	@Override
	public String toString() {
		return "MemberVO [memberNo=" + memberNo + ", memberId=" + memberId + ", memberPassword=" + memberPassword
				+ ", memberName=" + memberName + ", memberNickname=" + memberNickname + ", memberEmail=" + memberEmail
				+ ", memberPhoneNo=" + memberPhoneNo + ", memberGender=" + memberGender + ", memberRole=" + memberRole + "]";
	}
}
