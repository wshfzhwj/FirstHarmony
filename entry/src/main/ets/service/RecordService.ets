import RecordModel from '../viewmodel/RecordViewModel'
import { RecordTypeEnum, RecordTypes } from '../model/RecordType'
import DateUtil from '../utils/DateUtil'
import GroupInfo from '../model/GroupInfoModel'
import RecordType from '../model/RecordTypeModel'
import RecordVO from '../model/RecordModel'
import StatsInfo from '../model/StatsInfoModel'
import ItemViewModel from '../viewmodel/ItemViewModel'

class RecordService {
  /**
   * 新增饮食记录
   * @param typeId 记录类型id
   * @param itemId 记录项id
   * @param amount 记录项数量（食物量、运动时长）
   * @returns 新增数量
   */
  insert(typeId: number, itemId: number, amount: number): Promise<number> {
    // 1.获取时间
    let createTime = (AppStorage.get('selectedDate') || DateUtil.beginTimeOfDay(new Date())) as number
    // 2.新增
    return RecordModel.insert({
      typeId,
      itemId,
      amount,
      createTime
    })
  }

  /**
   * 根据id删除饮食记录
   * @param id 记录id
   * @returns 删除条数
   */
  deleteById(id: number): Promise<number> {
    return RecordModel.deleteById(id)
  }

  /**
   * 根据日期查询饮食记录列表
   * @param date 要查询的日期
   * @returns 记录列表
   */
  async queryRecordByDate(date: number): Promise<RecordVO[]> {
    // 1.查询数据库的RecordPO
    let rps = await RecordModel.listByDate(date)
    // 2.将RecordPO转为RecordVO
    return rps.map(rp => {
      // 2.1.获取po中的基本属性
      // 2.2.查询记录项
      let recordItem = ItemViewModel.getById(rp.itemId!!, rp.typeId !== RecordTypeEnum.WORKOUT)
      // 2.3.计算热量
      let calorie = rp.amount!! * recordItem.calorie
      return new RecordVO(rp.id!,rp.typeId!,calorie,recordItem,rp.amount!)
    })
  }

  /**
   * 根据记录列表信息统计出热量、营养素信息
   * @param records 饮食记录列表
   * @returns 热量、营养素信息
   */
  calculateStatsInfo(records: RecordVO[]): StatsInfo {
    // 1.准备结果
    let info = new StatsInfo()
    if (!records || records.length <= 0) {
      return info
    }
    // 2.计算统计数据
    records.forEach(r => {
      if (r.typeId === RecordTypeEnum.WORKOUT) {
        // 运动，累加消耗热量
        info.expend += r.calorie
      } else {
        // 食物，累加摄入热量、蛋白质、碳水、脂肪
        info.intake += r.calorie
        info.carbon += r.recordItem.carbon
        info.protein += r.recordItem.protein
        info.fat += r.recordItem.fat
      }
    })
    // 3.返回
    return info
  }

  /**
   * 将记录列表按照记录类型分组
   * @param records 记录列表
   * @returns 分组记录信息
   */
  calculateGroupInfo(records: RecordVO[]): GroupInfo<RecordType, RecordVO>[] {
    // 1.创建空的记录类型分组
    let groups = RecordTypes.map(recordType => new GroupInfo(recordType, []))
    if (!records || records.length <= 0) {
      return groups
    }
    // 2.遍历所有饮食记录，
    records.forEach(record => {
      // 2.1.把每个记录存入其对应类型的分组中
      groups[record.typeId].items.push(record as never)
      // 2.2.计算该组的总热量
      groups[record.typeId].calorie += record.calorie
    })
    return groups
  }
}

let recordService = new RecordService()

export default recordService as RecordService