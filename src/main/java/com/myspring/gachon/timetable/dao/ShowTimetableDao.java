package com.myspring.gachon.timetable.dao;

import java.util.List;

import com.myspring.gachon.timetable.vo.ShowTimetableVo;

public interface ShowTimetableDao {
	List<ShowTimetableVo> selectTimetableinfo(int memberId);
}
