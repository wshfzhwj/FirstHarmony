export default class GroupInfoModel<T, E> {
  /**
   * 分组类型
   */
  type: T
  /**
   * 组内数据集合
   */
  items: E[]

  /**
   * 组内记录的总热量
   */
  calorie: number = 0

  constructor(type: T, items: E[]) {
    this.type = type
    this.items = items
  }
}