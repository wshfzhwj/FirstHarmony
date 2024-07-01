import RecordTypeModel from './RecordTypeModel'

enum RecordTypeEnum {
  /**
   * 早餐
   */
  BREAKFAST,
  /**
   * 午餐
   */
  LUNCH,
  /**
   * 晚餐
   */
  DINNER,
  /**
   * 加餐
   */
  EXTRA_MEAL,
  /**
   * 运动
   */
  WORKOUT
}

/**
 * 记录类型常量
 */
const RecordTypeModels: RecordTypeModel[] = [
  new RecordTypeModel(0, $r("app.string.breakfast"), $r("app.media.ic_breakfast"), 423, 592),
  new RecordTypeModel(1, $r("app.string.lunch"), $r("app.media.ic_lunch"), 592, 761),
  new RecordTypeModel(2, $r("app.string.dinner"), $r("app.media.ic_dinner"), 423, 592),
  new RecordTypeModel(3, $r("app.string.extra_meal"), $r("app.media.ic_extra_m"), 0, 169),
  new RecordTypeModel(4, $r("app.string.workout"), $r("app.media.ic_workout")),
]

export {RecordTypeModels as RecordTypes, RecordTypeEnum}