package com.wangchao.ssm.pojo;

import java.util.Date;

public class User {
	
    private int userId;
    private String userName;		//用户名
    private String sex;
    private int age;
    private String userAccount;		//账户
    private String password;		//密码
    private Date lastLoginTime;		//上次登录时间
    
    private String birthday;		//生日
    private String personalSign;	//个性签名
    private String bloodType;		//血型
    private String currentAddress;	//现居地
    private String hometown;		//故乡
    private String emotion;			//感情状况：单身、恋爱中、已婚、（离异）
    private String constellation;	//星座
    private String hobby;			//爱好
    private String prefessional;	//职业
    private String company;			//公司
    
    private String masterHope;//主人寄语
   
	public Date getLastLoginTime() {
		return lastLoginTime;
	}

	public void setLastLoginTime(Date lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}

	public String getUserAccount() {
		return userAccount;
	}

	public void setUserAccount(String userAccount) {
		this.userAccount = userAccount;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex == null ? null : sex.trim();
    }

	public String getMasterHope() {
		return masterHope;
	}

	public void setMasterHope(String masterHope) {
		this.masterHope = masterHope;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getPersonalSign() {
		return personalSign;
	}

	public void setPersonalSign(String personalSign) {
		this.personalSign = personalSign;
	}

	public String getBloodType() {
		return bloodType;
	}

	public void setBloodType(String bloodType) {
		this.bloodType = bloodType;
	}

	public String getCurrentAddress() {
		return currentAddress;
	}

	public void setCurrentAddress(String currentAddress) {
		this.currentAddress = currentAddress;
	}

	public String getHometown() {
		return hometown;
	}

	public void setHometown(String hometown) {
		this.hometown = hometown;
	}

	public String getEmotion() {
		return emotion;
	}

	public void setEmotion(String emotion) {
		this.emotion = emotion;
	}

	public String getConstellation() {
		return constellation;
	}

	public void setConstellation(String constellation) {
		this.constellation = constellation;
	}

	public String getHobby() {
		return hobby;
	}

	public void setHobby(String hobby) {
		this.hobby = hobby;
	}

	public String getPrefessional() {
		return prefessional;
	}

	public void setPrefessional(String prefessional) {
		this.prefessional = prefessional;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}
    
}