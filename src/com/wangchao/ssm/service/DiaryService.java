package com.wangchao.ssm.service;

import java.util.List;

import com.wangchao.ssm.pojo.Diary;
import com.wangchao.ssm.pojo.DiaryContent;

public interface DiaryService {

	/**
	 * 添加一条日志内容表详细记录
	 */
	public int addDiaryContent(DiaryContent diaryContent);

	/**
	 * 添加一条日志表记录
	 */
	public int addDiary(Diary diary2);
	
	/**
	 * 查找我的日志list
	 */
	public List<Diary> queryMyDiaryList(int userId);
	/**
	 * 根据diaryContentId查找日志详细内容
	 */
	public DiaryContent queryDiaryByDiaryContentId(String diaryContentId);

	public int updateDiaryContentByContentId(DiaryContent diary);

	public int updateDiaryByContentId(Diary diary2);
	
	public int deleteDiaryByDiaryContentId(Diary diary);

	public int deleteDiaryContentByDiaryContentId(DiaryContent diaryContent);
}
