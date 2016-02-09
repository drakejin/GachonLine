package com.myspring.gachon.timetable.dao;

import java.util.List;

import com.myspring.gachon.timetable.vo.ShareTimetableVo;
import com.myspring.gachon.timetable.vo.ShowTimetableVo;

public interface ShareTimetableDao {
	List<ShareTimetableVo> selectMyfnd(int memberId);
	List<ShareTimetableVo> selectFndInfo(int memberId);

}
