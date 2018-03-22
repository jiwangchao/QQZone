package com.wangchao.ssm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.wangchao.ssm.mapper.DiaryMapper;
import com.wangchao.ssm.pojo.Diary;
import com.wangchao.ssm.pojo.DiaryContent;
import com.wangchao.ssm.service.DiaryService;

public class DiaryServiceImpl implements DiaryService {

	@Autowired
	private DiaryMapper diaryMapper;
	
	@Override
	public int addDiaryContent(DiaryContent diaryContent) {
		return diaryMapper.addDiaryContent(diaryContent);
	}

	@Override
	public int addDiary(Diary diary2) {
		return diaryMapper.addDiary(diary2);
	}

	@Override
	public List<Diary> queryMyDiaryList(int userId) {
		return diaryMapper.queryMyDiaryList(userId);
	}

	@Override
	public DiaryContent queryDiaryByDiaryContentId(String diaryContentId) {
		return diaryMapper.queryDiaryByDiaryContentId(diaryContentId);
	}

	@Override
	public int updateDiaryContentByContentId(DiaryContent diary) {
		return diaryMapper.updateDiaryContentByContentId(diary);
	}

	@Override
	public int updateDiaryByContentId(Diary diary2) {
		return diaryMapper.updateDiaryByContentId(diary2);
	}

	@Override
	public int deleteDiaryByDiaryContentId(Diary diary) {
		return diaryMapper.deleteDiaryByDiaryContentId(diary);
	}

	@Override
	public int deleteDiaryContentByDiaryContentId(DiaryContent diaryContent) {
		return diaryMapper.deleteDiaryContentByDiaryContentId(diaryContent);
	}

}
