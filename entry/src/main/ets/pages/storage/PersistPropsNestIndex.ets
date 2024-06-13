import router from '@ohos.router'
import Person from '../../model/Person'


PersistentStorage.PersistProp("user", '{"name":"lili","age":18}')

@Entry
@Component
struct PersistPropsNestIndex {
  @StorageLink("user")
  @Watch("update")
  userData: string = ""
  @State user: Person = JSON.parse(this.userData)

  update() {
    this.user = JSON.parse(this.userData)
  }

  build() {
    Column() {
      Text(this.user.name + "----" + this.user.age)
      Button("修改age").onClick(() => {
        this.user.age++
        AppStorage.Set<string>("user", JSON.stringify(this.user))
      })
      Button("去其他页面").onClick(() => {
        router.pushUrl({
          url: "pages/storage/PersistPropsOtherIndex"
        })
      })

      Button("获取").onClick(() => {
        const user = AppStorage.Get<string>("user")
        console.log(user)
      })

      Button("AppStorage Set 修改1").onClick(() => {
        AppStorage.Set<string>("user", JSON.stringify({ "name": "lisa", "age": 20 }))
      })

      Button("AppStorage Link 修改2").onClick(() => {
        const userLink: SubscribedAbstractProperty<string> = AppStorage.Link("user")
        userLink.set(JSON.stringify({ "name": "jack", "age": 20 }))
      })
    }
    .width("100%")
    .height("100%")
  }
}


 