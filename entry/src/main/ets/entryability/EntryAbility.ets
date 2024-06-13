import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import { CommonConstants } from '../constants/CommonConstants';
import DateUtil from '../utils/DateUtil';
import DbUtil from '../utils/DbUtil';
import PreferenceUtil from '../utils/PreferenceUtil'
import RecordModel from '../model/RecordModel';

export default class EntryAbility extends UIAbility {
  // storage:LocalStorage = new LocalStorage({cityName:'北京'})

  async onCreate(want, launchParam) {
    PreferenceUtil.loadPreference(this.context)
    AppStorage.SetOrCreate(CommonConstants.RECORD_DATE,DateUtil.beginTimeOfDay(new Date()))
    await DbUtil.initDB(this.context)
    DbUtil.createTable(RecordModel.getCreateTableSql())
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/WelcomeIndex', (err, data) => {
    // windowStage.loadContent('pages/storage/LocalStorageSharedIndex',this.storage, (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground() {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground() {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
