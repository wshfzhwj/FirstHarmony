import distributedKVStore from '@ohos.data.distributedKVStore';
import { BusinessError } from '@kit.BasicServicesKit';

export class DiaryKVStore {
  public kvManager: distributedKVStore.KVManager | undefined = undefined;
  public kvStore: distributedKVStore.SingleKVStore | undefined = undefined;

  async initKVManager() {
    if ((this.kvManager) !== undefined) {
      return;
    }
    let config: distributedKVStore.KVManagerConfig = {
      bundleName: 'com.saint.myapplication',
      context: getContext(this),
    }
    console.log('[DiaryKV] createKVManager begin')
    this.kvManager = await distributedKVStore.createKVManager(config)
    console.log('[DiaryKV] createKVManager end')
  }

  async initKVStore() {
    if ((this.kvStore) !== undefined) {
      return;
    }
    if ((this.kvManager) === undefined) {
      await this.initKVManager()
    }
    let options: distributedKVStore.Options = {
      createIfMissing: true,
      encrypt: false,
      backup: false,
      kvStoreType: distributedKVStore.KVStoreType.SINGLE_VERSION,
      securityLevel: distributedKVStore.SecurityLevel.S1,
    }
    console.log('[DiaryKV] kvManager.getKVStore begin')
    this.kvStore = await this.kvManager!!.getKVStore('storeId', options);
    console.log('[DiaryKV] kvManager.getKVStore end')
  }

  //写入数据
  putKVStore(key: string, value: string): Promise<void> {
    return new Promise((resolve, reject) => {
      this.kvStore!!.put(key, value).then(() => {
        console.info('Succeeded in putting data.');
        resolve()
      }).catch((err: BusinessError) => {
        console.error(`Failed to put data. Code:${err.code},message:${err.message}`);
        reject(err);
      });
    })

  }

  getKVStore(key: string): Promise<boolean | string | number | Uint8Array> {
    return new Promise((resolve, reject) => {
      this.kvStore!!.get(key).then((data) => {
        console.info(`Succeeded in getting data. data:${data}`);
        resolve(data)
      }).catch((err: BusinessError) => {
        console.error(`Failed to get data. Code:${err.code},message:${err.message}`);
        reject(err)
        return;
      })
    })
  }


  delKVStore(key: string): Promise<void> {
    return new Promise((resolve, reject) => {
      this.kvStore!!.delete(key).then((data) => {
        console.info('Succeeded in deleting data.');
        resolve(data)
      }).catch((err: BusinessError) => {
        console.error(`Failed to delete data. Code:${err.code},message:${err.message}`);
        reject(err)
        return;
      })
    })
  }

  onSubscribe() {
    try {
      this.kvStore!!.on('dataChange', distributedKVStore.SubscribeType.SUBSCRIBE_TYPE_ALL, //分布式数据库订阅类型为全部
        (data) => {
          console.info("xxxxxx---dataChange:" + JSON.stringify(data));
        });
      console.info("xxxxxx---subscribe success");
    } catch (err) {
      console.info("xxxxxx---subscribe error");
    }
  }
}

let diaryKVStore: DiaryKVStore = new DiaryKVStore();

export default diaryKVStore as DiaryKVStore