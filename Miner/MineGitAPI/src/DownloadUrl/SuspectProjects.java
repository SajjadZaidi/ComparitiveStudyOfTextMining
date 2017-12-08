package DownloadUrl;

import java.util.ArrayList;
import java.util.List;

import com.google.gson.internal.LinkedTreeMap;

public class SuspectProjects {

	String releasesUrl ;
	String name ;
	String fullname ;	
	String htmlUrl ;
	String creationDate ;
	String updateDate ;
	Double stars ;
	Double forks ;
	Double Scores ;
	Double Watchers ;
	Double open_issues_count ;
	Double size ;
	String language ;
	Double subscribers_count ;
	Double network_count ;
	List<LanguageCount> langaugeCount;
	public String getReleasesUrl() {
		return releasesUrl;
	}
	public void setReleasesUrl(String releasesUrl) {
		this.releasesUrl = releasesUrl;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getFullname() {
		return fullname;
	}
	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	public String getHtmlUrl() {
		return htmlUrl;
	}
	public void setHtmlUrl(String htmlUrl) {
		this.htmlUrl = htmlUrl;
	}
	public String getCreationDate() {
		return creationDate;
	}
	public void setCreationDate(String creationDate) {
		this.creationDate = creationDate;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	public Double getStars() {
		return stars;
	}
	public void setStars(Double stars) {
		this.stars = stars;
	}
	public Double getForks() {
		return forks;
	}
	public void setForks(Double forks) {
		this.forks = forks;
	}
	public Double getScores() {
		return Scores;
	}
	public void setScores(Double scores) {
		Scores = scores;
	}
	public Double getWatchers() {
		return Watchers;
	}
	public void setWatchers(Double watchers) {
		Watchers = watchers;
	}
	public Double getOpen_issues_count() {
		return open_issues_count;
	}
	public void setOpen_issues_count(Double open_issues_count) {
		this.open_issues_count = open_issues_count;
	}
	public Double getSize() {
		return size;
	}
	public void setSize(Double size) {
		this.size = size;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public Double getSubscribers_count() {
		return subscribers_count;
	}
	public void setSubscribers_count(Double subscribers_count) {
		this.subscribers_count = subscribers_count;
	}
	public Double getNetwork_count() {
		return network_count;
	}
	public void setNetwork_count(Double network_count) {
		this.network_count = network_count;
	}
	public List<LanguageCount> getLangaugeCount() {
		return langaugeCount;
	}
	public void setLangaugeCount(List<LanguageCount> langaugeCount) {
		this.langaugeCount = langaugeCount;
	}
	public SuspectProjects(String releasesUrl, String name, String fullname, String htmlUrl, String creationDate,
			String updateDate, Double stars, Double forks, Double scores, Double watchers, Double open_issues_count,
			Double size, String language, Double subscribers_count, Double network_count,
			List<LanguageCount> langaugeCount) {
		super();
		this.releasesUrl = releasesUrl;
		this.name = name;
		this.fullname = fullname;
		this.htmlUrl = htmlUrl;
		this.creationDate = creationDate;
		this.updateDate = updateDate;
		this.stars = stars;
		this.forks = forks;
		Scores = scores;
		Watchers = watchers;
		this.open_issues_count = open_issues_count;
		this.size = size;
		this.language = language;
		this.subscribers_count = subscribers_count;
		this.network_count = network_count;
		this.langaugeCount = langaugeCount;
	}


}
