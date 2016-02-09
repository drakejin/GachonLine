package com.myspring.gachon.timetable.dao;

import java.util.List;

import com.myspring.gachon.timetable.vo.ProTimetableVo;

public interface ProTimetableDao {
	List<ProTimetableVo> selectProTimetableinfo(ProTimetableVo vo);
}
