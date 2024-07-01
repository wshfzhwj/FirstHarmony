import GroupInfoModel from '../model/GroupInfoModel'
import { FoodCategories, WorkoutCategories } from '../model/ItemCategory'
import { foods,workouts } from '../model/RecordItemConstant'
import RecordItemModel from '../model/RecordItemModel'
class ItemViewModel{

  getById(id: number, isFood: boolean = true){
    return isFood ? foods[id] : workouts[id - 10000]
  }

  list(isFood: boolean = true): RecordItemModel[]{
    return isFood ? foods : workouts
  }

  listItemGroupByCategory(isFood: boolean = true){
    // 1.判断要处理的是食物还是运动
    let categories = isFood ? FoodCategories : WorkoutCategories
    let items: RecordItemModel[]= isFood ? foods: workouts
    // 2.创建空的分组
    let groups = categories.map(itemCategory => new GroupInfoModel(itemCategory, []))
    // 3.遍历记录项列表，将食物添加到对应的分组
    items.forEach((item:RecordItemModel) => groups[item.categoryId].items.push(item as never))
    // 4.返回结果
    return groups
  }
}

let itemViewModel = new ItemViewModel()

export default itemViewModel as ItemViewModel