//
//  LGVertexArrayObject.m
//  opengl-lesson-review
//
//  Created by Sam on 2020/3/23.
//  Copyright © 2020 Sam. All rights reserved.
//

#import "LGVertexArrayObject.h"
@interface LGVertexArrayObject()
@property (nonatomic, assign) GLuint vao;
@property (nonatomic, assign) BOOL hasEbo;
@property (nonatomic, assign) GLuint indexesCount;
@property (nonatomic, assign) GLuint vertexesCount;
@end
@implementation LGVertexArrayObject
- (instancetype)init {
    if (self = [super init]) {
        GLuint vao;
        glGenVertexArrays(1, &vao);
        self.vao = vao;
    }
    return self;
}

- (void)addVertexBufferObject:(LGVertexBufferObject *)vbo {
    [self bind];
    glBindBuffer(GL_ARRAY_BUFFER, vbo.vbo);
    
    GLfloat vertexes[vbo.vertexArray.count];
    for (int i = 0; i < vbo.vertexArray.count; i ++) {
        vertexes[i] = (GLfloat)[vbo.vertexArray[i] floatValue];
    }
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertexes), vertexes, GL_STATIC_DRAW);
    
    int sum = 0;
    for (int i = 0; i < vbo.lineWidth.count; i ++) {
        sum += [vbo.lineWidth[i] intValue];
    }
    
    // https://www.zhihu.com/question/39295898
    for (int i = 0, offset = 0; i < vbo.lineWidth.count; i ++) {
        int lineWidth = [vbo.lineWidth[i] intValue];
        glVertexAttribPointer(i, lineWidth, GL_FLOAT, GL_FALSE, sum * sizeof(float), (void *)(offset * sizeof(float)));
        glEnableVertexAttribArray(i);
        offset += lineWidth;
    }
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindVertexArray(0);
    self.vertexesCount = (GLuint)vbo.vertexArray.count / sum;
    [self bind];
}

- (void)addElementBufferObject:(LGElementBuffereObject *)ebo {
    [self bind];
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, ebo.ebo);
    
    int indexes[ebo.indexArray.count];
    for (int i = 0; i < ebo.indexArray.count; i ++) {
        indexes[i] = [ebo.indexArray[i] intValue];
    }
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indexes), indexes, GL_STATIC_DRAW);
    self.hasEbo = YES;
    self.indexesCount = (GLuint)ebo.indexArray.count;
    [self unbind];
}

- (void)draw {
    [self bind];
    glBindVertexArray(self.vao);
    if (self.hasEbo) {
        glDrawElements(GL_TRIANGLES, self.indexesCount, GL_UNSIGNED_INT, 0);
    } else {
        glDrawArrays(GL_TRIANGLES, 0, self.vertexesCount);
    }
    [self unbind];
}

- (void)bind {
    glBindVertexArray(self.vao);
}
- (void)unbind {
    glBindVertexArray(0);
}
@end
