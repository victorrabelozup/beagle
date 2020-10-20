/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package br.com.zup.beagle.android.action

import androidx.lifecycle.MutableLiveData

/**
 * Class that represents async actions in Beagle
 * @property status represents the current state of execution of the action
 */
abstract class AsyncAction : Action {

    @Transient
    val status: MutableLiveData<ActionStatus> = MutableLiveData()

    /**
     * Updates action status to finished
     */
    fun setActionFinished() {
        status.value = ActionStatus.FINISHED
        status.value = ActionStatus.IDLE
    }

    /**
     * Updates action status to started
     */
    fun setActionStarted() {
        status.value = ActionStatus.STARTED
    }
}

/**
 * Status of asynchronous actions
 */
enum class ActionStatus {
    STARTED,
    FINISHED,
    IDLE
}
