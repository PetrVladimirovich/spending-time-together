DROP TABLE IF EXISTS compilation_events;
DROP TABLE IF EXISTS compilations;
DROP TABLE IF EXISTS requests;
DROP TABLE IF EXISTS events;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS categories;

CREATE TABLE IF NOT EXISTS categories(
    id INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    name VARCHAR(50) NOT NULL,
    CONSTRAINT pk_categories PRIMARY KEY (id),
    CONSTRAINT un_name UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS users(
    id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    status BOOLEAN DEFAULT FALSE,
    CONSTRAINT pk_users PRIMARY KEY (id),
    CONSTRAINT un_email UNIQUE (email)
);

CREATE TABLE IF NOT EXISTS events(
    id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    annotation VARCHAR(2000) NOT NULL,
    category_id INTEGER NOT NULL,
    created_on TIMESTAMP NOT NULL,
    description VARCHAR(7000) NOT NULL,
    event_date TIMESTAMP NOT NULL,
    user_id BIGINT NOT NULL,
    lat FLOAT4 NOT NULL,
    lon FLOAT4 NOT NULL,
    paid BOOLEAN DEFAULT FALSE,
    participant_limit INTEGER DEFAULT 0,
    published_on TIMESTAMP,
    request_moderation BOOLEAN DEFAULT TRUE,
    state VARCHAR(50) NOT NULL,
    title VARCHAR(120) NOT NULL,
    CONSTRAINT pk_events PRIMARY KEY (id),
    CONSTRAINT fk_events_users FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_events_categories FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS requests(
    id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    user_id BIGINT NOT NULL,
    event_id BIGINT NOT NULL,
    created TIMESTAMP NOT NULL,
    status VARCHAR(50) NOT NULL,
    CONSTRAINT pk_requests PRIMARY KEY (id),
    CONSTRAINT fk_requests_users FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_requests_events FOREIGN KEY (event_id) REFERENCES events (id) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT un_user_event UNIQUE (user_id, event_id)
);

CREATE TABLE IF NOT EXISTS compilations(
    id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    pinned BOOLEAN DEFAULT FALSE,
    title VARCHAR(500) NOT NULL,
    CONSTRAINT pk_compilations PRIMARY KEY (id),
    CONSTRAINT un_title UNIQUE (title)
);

CREATE TABLE IF NOT EXISTS compilation_events(
    id_compilation BIGINT NOT NULL,
    id_event BIGINT NOT NULL,
    CONSTRAINT pk_compilation_events PRIMARY KEY (id_compilation, id_event),
    CONSTRAINT fk_compilation_events_compilations FOREIGN KEY (id_compilation) REFERENCES compilations (id) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_compilation_events_events FOREIGN KEY (id_event) REFERENCES events (id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS event_likes(
     id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
     id_event BIGINT NOT NULL,
     id_user BIGINT NOT NULL,
     reaction VARCHAR(50),
     created TIMESTAMP NOT NULL,
     CONSTRAINT pk_event_likes PRIMARY KEY (id),
     CONSTRAINT fk_event_likes_events FOREIGN KEY (id_event) REFERENCES events (id) ON DELETE CASCADE ON UPDATE CASCADE,
     CONSTRAINT fk_event_likes_users FOREIGN KEY (id_user) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE,
     CONSTRAINT un_event_user UNIQUE (id_event, id_user)
 );