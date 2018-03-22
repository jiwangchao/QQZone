package com.wangchao.ssm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.wangchao.ssm.pojo.Diary;
import com.wangchao.ssm.pojo.DiaryContent;

public interface DiaryMapper {

	public int addDiaryContent(DiaryContent diaryContent);

	public int addDiary(Diary diary2);

	public List<Diary> queryMyDiaryList(@Param("userId")int userId);

	public DiaryContent queryDiaryByDiaryContentId(@Param("diaryContentId")String diaryContentId);

	public int updateDiaryContentByContentId(DiaryContent diary);

	public int updateDiaryByContentId(Diary diary2);

	public int deleteDiaryByDiaryContentId(Diary diary);

	public int deleteDiaryContentByDiaryContentId(DiaryContent diaryContent);
}
