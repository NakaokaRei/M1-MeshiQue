import cv2
import numpy as np
import keras
from collections import Counter

import socketio

cap = cv2.VideoCapture(0)

model = keras.models.load_model('model/demo_vgg_val_acc.h5')
model._make_predict_function()
classes = ['bk', 'bn', 'gn', 'pl', 'rd', 'wt', 'ye', 'goal', 'none']
colors = ['wt', 'ye', 'rd', 'gn']
color2cmd = {'wt': 0, 'ye': 1, 'rd': 2, 'gn': 3}
color_list = []
previous_class = ""

sio = socketio.Client()
@sio.event
def connect():
    goal_num = 0
    print('conneced')
    while True:
        # VideoCaptureから1フレーム読み込む
        ret, frame = cap.read()
        frame_ = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        frame_ = cv2.resize(frame_, (224, 224))
        predict = model.predict(np.float32(frame_.reshape([1, 224, 224, 3]))/255.0)
        y = predict[0].argmax()
        class_name = classes[y]
        if max(predict[0]) > 0.7:
            if class_name == "goal":
                if previous_class == "goal":
                    goal_num += 1
                elif previous_class != "goal":
                    goal_num = 0
                    goal_num += 1
            else:
                goal_num = 0
                if len(color_list) > 20:
                    del color_list[0]
                color_list.append(class_name)
            previous_class = class_name
        
        # 玉をゴールのうつわに移したときの処理
        if goal_num > 4:
            goal_num = 0
            controalColor = Counter(color_list).most_common()[0][0]
            if controalColor in colors:
                cmd = color2cmd[controalColor]
                sio.emit('sensor', cmd)
                #print(controalSignal)
                print("{}を入れた".format(controalColor))

        
        pro = max(predict[0])
        # 加工済の画像を表示する
        #print(class_name)
        cv2.putText(frame,'{}_{:.2f}'.format(class_name,pro), (0,50), cv2.FONT_HERSHEY_PLAIN, 3, (0, 255,0), 3, cv2.LINE_AA)
        #frame = cv2.cvtColor(frame, cv2.COLOR_RGB2BGR)``
        cv2.imshow('frame', frame)
        # キー入力を1ms待って、k が27（ESC）だったらBreakする
        k = cv2.waitKey(60)
        if k == 27:
            break

    # キャプチャをリリースして、ウィンドウをすべて閉じる
    cap.release()
    cv2.destroyAllWindows()
# キャプチャをリリースして、ウィンドウをすべて閉じる
sio.connect('http://0.0.0.0:5000')
