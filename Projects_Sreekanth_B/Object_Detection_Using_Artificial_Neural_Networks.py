# Created by Sreekanth_B
# Developing the Object Detection using Using Artificial Neural Networks and Deep learning concepts 

# using open source databases (Keras) for large data training  ...

import keras
from keras.datasets import mnist
from keras.layers import Dense
from keras.models import Sequential
from keras.optimizers import SGD
import matplotlib.pyplot as plt
from keras.preprocessing import image

(train_x, train_y) , (test_x, test_y) = mnist.load_data()
train_x = train_x.astype('float32') / 255
test_x = test_x.astype('float32') / 255

print(train_x.shape)
print(train_y.shape)
print(test_x.shape)
print(test_y.shape)

train_x = train_x.reshape(60000,784)
test_x = test_x.reshape(10000,784)

train_y = keras.utils.to_categorical(train_y,10)
test_y = keras.utils.to_categorical(test_y,10)

model = Sequential()
model.add(Dense(units=128,activation="relu",input_shape=(784,)))
model.add(Dense(units=128,activation="relu"))
model.add(Dense(units=128,activation="relu"))
model.add(Dense(units=128,activation="relu"))
model.add(Dense(units=10,activation="softmax"))

model.compile(optimizer=SGD(0.001),loss="categorical_crossentropy",metrics=["accuracy"])
#model.load_weights("mnistmodl.h5")
model.fit(train_x,train_y,batch_size=32,epochs=10,verbose=1)

model.save("mnistmodl.h5")

accuracy = model.evaluate(x=test_x,y=test_y,batch_size=32)

print("Accuracy: ",accuracy[1])

#Normalize the test dataset
test_x = test_x.astype('float32') / 255

img =image.load_img(path="img_58.jpg",grayscale=True,target_size=(28,28))
img = image.img_to_array(img)
img = img.reshape((28,28))
#Create a flattened copy of the image
test_img = img.reshape((1,784))
#Predict the class
img_class = model.predict_classes(test_img)
classname = img_class[0]
print("Class: ",classname)
#Display the original non-flattened copy of the image
plt.title("Prediction Result: %s"%(classname))
plt.imshow(img)
plt.show()

