import hilog from '@ohos.hilog'
import distributedKVStore from '@ohos.data.distributedKVStore'
import { Diary } from '../bean/Diary'
import { DiaryKVStore } from '../utils/DiaryKVStore'

export class DiaryService {
  diaryKV = new DiaryKVStore
  keyPrefix = 'k'

  init() {
    this.diaryKV.initKVManager()
    this.diaryKV.initKVStore()
  }

  add(diary: Diary, callback: Function) {
    const KEY = this.keyPrefix + diary.getDate();
    const VALUE = diary.toJSONString();

    try {
      this.diaryKV.kvStore!!.put(KEY, VALUE, (err, data) => {
        if (err != undefined) {
          console.log(`put err: ${err}`);
          callback("添加日记失败！");
          return;
        }
        console.log(`put success ${data}`);
        callback("添加日记成功！");
      });

    } catch (e) {
      console.log(`Error： ${e}`);
      callback("添加日记失败！")
    }
  }


  queryAll(callback: Function) {
    hilog.info(0x0001, `failed %{public}%s`, 'queryAll')
    let promise = this.diaryKV.kvStore!!.getEntries(this.keyPrefix)
    let arr = []
    if (promise != null) {
      promise.then((data) => {
        hilog.info(0x0001, 'failed %{public}%s', 'queryAll2')
        for (let i = 0;i < data.length; i++) {
          arr.push(JSON.parse('' + data[i].value.value) as never)
        }
      })
    }
    callback(arr)
  }

  queryById(kid : string, callback: Function) {
    try {
      const KEY = this.keyPrefix + kid;
      this.diaryKV.kvStore!!.get(KEY, (err, data) => {
        if (err) {
          console.log(`getKVStore err: ${err}`);
          callback("无数据");
          return;
        }
        callback(data);
        console.log(`get success data: ${data}`);
      })
    } catch (e) {
      callback("")
      console.log(`Error： ${e}`);
    }
  }

  deleteByKID(kid:string, callback: Function) {
    try {
      const KEY = this.keyPrefix + kid;
      this.diaryKV.kvStore!!.delete(KEY, (err, data) => {
        if (err != undefined) {
          console.log(`delete err: ${err}`);
          callback("删除失败");
          return;
        }
        callback(data);
        console.log(`get success data: ${data}`);
      })
    } catch (e) {
      callback("")
      console.log(`Error： ${e}`);
    }
  }

  update(diary: Diary, callback: Function) {
    const KEY = this.keyPrefix + diary.getDate();
    const VALUE = diary.toJSONString();

    try {
      this.diaryKV.kvStore!!.put(KEY, VALUE, (err, data) => {
        if (err != undefined) {
          console.log(`put err: ${err}`);
          callback("修改日记失败！");
          return;
        }
        console.log(`put success${data}`);
        callback("添加日记成功！");
      });

    } catch (e) {
      console.log(`Error： ${e}`);
      callback("修改日记失败！")
    }
  }

  sync() {
    let deviceIDs: [] = []
    this.diaryKV.kvStore!!.sync(deviceIDs, distributedKVStore.SyncMode.PUSH_PULL)
  }
}

export let diaryService = new DiaryService()
diaryService.init()