import ItemCategoryModel from './ItemCategoryModel'

/**
 * 食物类型的枚举
 */
enum FoodCategoryEnum{
  /**
   * 主食
   */
  STAPLE,
  /**
   * 蔬果
   */
  FRUIT,
  /**
   * 肉蛋奶
   */
  MEAT,
  /**
   * 坚果
   */
  NUT,
  /**
   * 其它
   */
  OTHER,
}

/**
 * 食物类型数组
 */
let FoodCategories = [
  new ItemCategoryModel(0, $r('app.string.staple')),
  new ItemCategoryModel(1, $r('app.string.fruit')),
  new ItemCategoryModel(2, $r('app.string.meat')),
  new ItemCategoryModel(3, $r('app.string.nut')),
  new ItemCategoryModel(4, $r('app.string.other_type')),
]

/**
 * 运动类型枚举
 */
enum WorkoutCategoryEnum {
  /**
   * 走路
   */
  WALKING,
  /**
   * 跑步
   */
  RUNNING,
  /**
   * 骑行
   */
  RIDING,
  /**
   * 跳操
   */
  AEROBICS,
  /**
   * 游泳
   */
  SWIMMING,
  /**
   * 打球
   */
  BALLGAME,
  /**
   * 力量训练
   */
  STRENGTH
}

/**
 * 运动类型数组
 */
let WorkoutCategories = [
  new ItemCategoryModel(0, $r('app.string.walking_type')),
  new ItemCategoryModel(1, $r('app.string.running')),
  new ItemCategoryModel(2, $r('app.string.riding')),
  new ItemCategoryModel(3, $r('app.string.aerobics')),
  new ItemCategoryModel(4, $r('app.string.swimming')),
  new ItemCategoryModel(5, $r('app.string.ballgame')),
  new ItemCategoryModel(6, $r('app.string.strength')),
]

export {FoodCategories , WorkoutCategories , FoodCategoryEnum, WorkoutCategoryEnum}